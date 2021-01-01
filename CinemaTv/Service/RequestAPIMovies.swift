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


final class RequestAPIMovies {
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 40
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadMovies(onComplete: @escaping (Movie?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: Constants.basePathMovies + Constants.apiKey + "&language=pt-BR&page=1") else {
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
                    print("Algo deu Errado no servidor dos Movies")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadMovieCast(movieID: Int, onComplete: @escaping (Cast?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(Constants.apiKey)&language=en-US") else {
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
                        let movies = try JSONDecoder().decode(Cast.self, from: data)
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
    
    class func loadDiscoverMovies(onComplete: @escaping (DiscoverMovies?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: Constants.basePathMovies + Constants.apiKey + "&language=pt-BR&page=1") else {
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
                        let movies = try JSONDecoder().decode(DiscoverMovies.self, from: data)
                        onComplete(movies)
                        print("FetchOK")
                    } catch let jsonErr {
                        onError(.invalidJSON)
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                   onError(.responseStatusCode(code: response.statusCode))
                    print("Algo deu Errado no servidor DiscoverMovies")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadDiscoverMoviesDetails(id: Int, onComplete: @escaping (PopularSeriesDetails?) -> Void, onError: @escaping (Err) -> Void) {
        let stringURL = "https://api.themoviedb.org/3/tv/\(id)?api_key=\(Constants.apiKey)&language=en-US"
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
                    print("Algo deu Errado no servidor dos detalhes DiscoverMovies")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadVideos(url: String, onComplete: @escaping (Videos?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: url) else {
            onError(.url)
            return
        }
        print("Videos", url)
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
