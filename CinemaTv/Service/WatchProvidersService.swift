//
//  WatchProvidersService.swift
//  CinemaTv
//
//  Created by Danilo Requena on 28/05/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

final class WatchProvidersService {
   private static let configuration: URLSessionConfiguration = {
       let config = URLSessionConfiguration.default
       config.httpMaximumConnectionsPerHost = 40
       return config
   }()
   
   private static let session = URLSession(configuration: configuration)

   class func loadProviders<T: Decodable>(
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
           URLQueryItem(name: "region", value: Locale.current.regionCode)
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
}
