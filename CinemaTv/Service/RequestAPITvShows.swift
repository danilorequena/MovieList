//
//  RequestAPITvShows.swift
//  CinemaTv
//
//  Created by Danilo Requena on 30/12/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation


final class RequestAPITVShows {
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 40
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadSeries<T: Decodable>(
        params: [String: String]?,
        endpoint: SeriesEndpoint,
        completion: @escaping (Result<T, APIServiceError>) -> ()
    ) {
        guard let queryURL = Constants.baseUrl?.appendingPathComponent(endpoint.path()) else  {
            completion(.failure(.url))
            return
        }
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: Locale.preferredLanguages[0]),
            URLQueryItem(name: "region", value: Locale.current.regionCode)
        ]
        
        if let params = params {
            for (_, value) in params.enumerated() {
                components.queryItems?.append(URLQueryItem(name: value.key, value: value.value))
            }
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.noResponse))
                    print("No Error")
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let series = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(series))
                        print("FetchOK")
                    } catch let jsonErr {
                        completion(.failure(.invalidJSON))
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                    completion(.failure(.responseStatusCode(code: response.statusCode)))
                    print("Algo deu Errado no servidor DiscoverSeries")
                }
            } else {
                completion(.failure(.taskError(error: error!)))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
}
