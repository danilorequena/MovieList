//
//  Interactor.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 29/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

enum Err {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}


class RequestAPI {
    private static let apiKey = "ddf20e1d6a0147313cfd3b4ac419e373"
    private static let basePathMovies = "https://api.themoviedb.org/3/movie/popular?api_key="
    private static let basePathPopularSeries = "https://api.themoviedb.org/3/tv/popular?api_key="
    private static let basePathLatestSeries = "https://api.themoviedb.org/3/tv/top_rated?api_key="
    
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 40
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadMovies(onComplete: @escaping (Movie?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: basePathMovies + apiKey + "&language=pt-BR&page=1") else {
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
                        let movies = try JSONDecoder().decode(Movie.self, from: data)
                        onComplete(movies)
                        print("FetchOK")
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
    
    
    class func loadPopularSeries(onComplete: @escaping (PopularSeries?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: basePathPopularSeries + apiKey + "&language=pt-BR&page=1") else {
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
                        let serie = try JSONDecoder().decode(PopularSeries.self, from: data)
                        onComplete(serie)
                        print("FetchOK")
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
    
    class func loadTopRatedSeries(onComplete: @escaping (TopRatedSeries?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: basePathLatestSeries + apiKey + "&language=en-US&page=1") else {
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
                        let serie = try JSONDecoder().decode(TopRatedSeries.self, from: data)
                        onComplete(serie)
                        print("FetchOK")
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
