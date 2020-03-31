//
//  Interactor.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 29/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation


class MoviesRequest {
    private static let apiKey = "ddf20e1d6a0147313cfd3b4ac419e373"
    private static let basePath = "https://api.themoviedb.org/3/movie/popular?api_key="
    
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 40
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    
    class func loadMovies(onComplete: @escaping (Movie?) -> Void) {
        guard let url = URL(string: basePath + apiKey + "&language=pt-BR&page=1") else {
            onComplete(nil)
            return
        }
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    do {
                        let movies = try JSONDecoder().decode(Movie.self, from: data)
                        onComplete(movies)
                    } catch {
                        onComplete(nil)
                    }
                } else {
                    onComplete(nil)
                    print("Algo deu Errado no servidor")
                }
            } else {
                onComplete(nil)
            }
        }
        dataTask.resume()
    }
}
