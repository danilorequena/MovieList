//
//  Interactor.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 29/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

 final class RequestAPIMovies {
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 40
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)

    class func loadMovies<T: Decodable>(
        page: String,
        endPoint: MoviesEndpoint,
        complitionHandler: @escaping (Result<T, APIServiceError>) -> ()
    ) {
        guard let queryURL = Constants.baseUrl?.appendingPathComponent(endPoint.path()) else {
            complitionHandler(.failure(.url))
            return
        }
        var components = URLComponents(url: queryURL,
                                       resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: Locale.preferredLanguages[0]),
            URLQueryItem(name: "region", value: Locale.current.regionCode),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "true"),
            URLQueryItem(name: "watch_region", value: Locale.current.regionCode),
            URLQueryItem(name: "page", value: page)
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"

        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    complitionHandler(.failure(.noResponse))
                    print("No Error")
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let movies = try JSONDecoder().decode(T.self, from: data)
                        complitionHandler(.success(movies))
                        print("FetchOK")
                    } catch let jsonErr {
                        complitionHandler(.failure(.invalidJSON))
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                    complitionHandler(.failure(.responseStatusCode(code: response.statusCode)))
                    print("Algo deu Errado no servidor dos Movies")
                }
            } else {
                complitionHandler(.failure(.taskError(error: error!)))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadVideos(
        url: String,
        complitionHandler: @escaping (Result<Videos?, APIServiceError>) -> ()
    ) {
        guard let url = URL(string: url) else {
            complitionHandler(.failure(.url))
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    complitionHandler(.failure(.noResponse))
                    print("No Error")
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let videos = try JSONDecoder().decode(Videos.self, from: data)
                        complitionHandler(.success(videos))
                    } catch let jsonErr {
                        complitionHandler(.failure(.invalidJSON))
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                    complitionHandler(.failure(.responseStatusCode(code: response.statusCode)))
                    print("Algo deu Errado no servidor")
                }
            } else {
                complitionHandler(.failure(.taskError(error: error!)))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
}
