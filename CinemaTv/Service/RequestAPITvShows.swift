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
    
    
    class func loadSeries<T: Decodable>(params: [String: String]?,
                                                endpoint: SeriesEndpoint,
                                                onComplete: @escaping (T) -> Void, onError: @escaping (APIServiceError) -> Void) {
        guard let queryURL = Constants.baseUrl?.appendingPathComponent(endpoint.path()) else  {
            onError(.url)
            return
        }
        var components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
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
                    onError(.noResponse)
                    print("No Error")
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let series = try JSONDecoder().decode(T.self, from: data)
                        onComplete(series)
                        print("FetchOK")
                    } catch let jsonErr {
                        onError(.invalidJSON)
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                   onError(.responseStatusCode(code: response.statusCode))
                    print("Algo deu Errado no servidor DiscoverSeries")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadPopularSeriesDetails(id: Int, onComplete: @escaping (PopularSeriesDetails?) -> Void, onError: @escaping (APIServiceError) -> Void) {
        let stringURL = "https://api.themoviedb.org/3/tv/\(id)?api_key=\(Constants.apiKey)&language=pt-BR"
        guard let url = URL(string: stringURL) else {
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
                        let serie = try JSONDecoder().decode(PopularSeriesDetails.self, from: data)
                        onComplete(serie)
                        print("FetchOK")
                    } catch let jsonErr {
                        onError(.invalidJSON)
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                   onError(.responseStatusCode(code: response.statusCode))
                    print("Algo deu Errado no servidor detalhes das series populares")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
}
