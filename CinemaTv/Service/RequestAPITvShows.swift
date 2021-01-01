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
    
    
    class func loadDiscoverSeries(onComplete: @escaping (DiscoverSeries?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: Constants.baseDiscoverSeries) else {
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
                        let series = try JSONDecoder().decode(DiscoverSeries.self, from: data)
                        onComplete(series)
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
    
    class func loadPopularSeries(url: String, onComplete: @escaping (PopularSeries?) -> Void, onError: @escaping (Err) -> Void) {
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
                        let serie = try JSONDecoder().decode(PopularSeries.self, from: data)
                        onComplete(serie)
                        print("FetchOK")
                    } catch let jsonErr {
                        onError(.invalidJSON)
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                   onError(.responseStatusCode(code: response.statusCode))
                    print("Algo deu Errado no servidor das series populares")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadTopRatedSeries(onComplete: @escaping (TopRatedSeries?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: Constants.basePathLatestSeries + Constants.apiKey + "&language=en-US&page=1") else {
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
    
    class func loadSeriesOnAir(url: String, onComplete: @escaping (SeriesOnAir?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: url) else {
            onError(.url)
            return
        }
        print("URLONAIR", url)
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
                        let movies = try JSONDecoder().decode(SeriesOnAir.self, from: data)
                        onComplete(movies)
                        print("FetchOK")
                    } catch let jsonErr {
                        onError(.invalidJSON)
                        print("Error serializing json:", jsonErr)
                    }
                } else {
                   onError(.responseStatusCode(code: response.statusCode))
                    print("Algo deu Errado no servidor das seriesOnAir")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadPopularSeriesDetails(id: Int, onComplete: @escaping (PopularSeriesDetails?) -> Void, onError: @escaping (Err) -> Void) {
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
                    print("Algo deu Errado no servidor detalhes das series populares")
                }
            } else {
                onError(.taskError(error: error!))
                print("Algo errado")
            }
        }
        dataTask.resume()
    }
    
    class func loadSeriesCast(serieID: Int, onComplete: @escaping (Cast?) -> Void, onError: @escaping (Err) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(serieID)/credits?api_key=\(Constants.apiKey)&language=en-US") else {
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
                        let series = try JSONDecoder().decode(Cast.self, from: data)
                        onComplete(series)
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