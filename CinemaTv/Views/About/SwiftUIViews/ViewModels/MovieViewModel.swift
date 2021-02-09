//
//  MovieViewModel.swift
//  CinemaTv
//
//  Created by Danilo Requena on 08/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies = [Result]()
    @Published var image = ImageLoader()
    
    init() {
        RequestAPIMovies.loadMovies(page: "1", endPoint: .discover) { (movies: Movie) in
            self.movies = movies.results
        } onError: { (error) in
            print(error)
        }
    }
}

struct MovieViewModel {
    var movie: Result
    
    init(movie: Result) {
        self.movie = movie
    }
    
    var title: String {
        return self.movie.title ?? ""
    }
    
    var overview: String {
        return self.movie.overview ?? ""
    }
}
