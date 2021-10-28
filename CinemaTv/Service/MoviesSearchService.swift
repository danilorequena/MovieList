//
//  MoviesSearchService.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/06/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

final class MoviesSearchService {
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 40
        return config
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadMoviesSearch<T: Decodable>(
        page: String,
        movie: String,
        endpoint: MoviesEndpoint,
        complitionHandler: @escaping (Result<T, APIServiceError>) -> ()
    ) {
        guard let queryURL = Constants.baseUrl?.appendingPathComponent(endpoint.path()) else {
            complitionHandler(.failure(.url))
            return
        }
        guard var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true) else { return }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "query", value: movie),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "region", value: Locale.current.regionCode),
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
}
    
