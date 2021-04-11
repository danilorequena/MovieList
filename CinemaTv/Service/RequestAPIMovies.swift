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
        onComplete: @escaping (T) -> Void,
        onError: @escaping (APIServiceError) -> Void
    ) {
        guard let queryURL = Constants.baseUrl?.appendingPathComponent(endPoint.path()) else {
            onError(.url)
            return
        }
        var components = URLComponents(url: queryURL,
                                       resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: Locale.preferredLanguages[0]),
            URLQueryItem(name: "page", value: page)
        ]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"

        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    print("No Error")
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let movies = try JSONDecoder().decode(T.self, from: data)
                        onComplete(movies)
                        print("FetchOK")
                    } catch let jsonErr {
                        onError(.invalidJSON)
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                   onError(.responseStatusCode(code: response.statusCode))
                    print("Algo deu Errado no servidor dos Movies")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadVideos(
        url: String,
        onComplete: @escaping (Videos?) -> Void,
        onError: @escaping (APIServiceError) -> Void
    ) {
        guard let url = URL(string: url) else {
            onError(.url)
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    print("No Error")
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let videos = try JSONDecoder().decode(Videos.self, from: data)
                        onComplete(videos)
                    } catch let jsonErr {
                        onError(.invalidJSON)
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                   onError(.responseStatusCode(code: response.statusCode))
                    print("Algo deu Errado no servidor")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
}
