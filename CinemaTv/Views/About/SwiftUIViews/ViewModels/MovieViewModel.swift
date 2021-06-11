//
//  MovieViewModel.swift
//  CinemaTv
//
//  Created by Danilo Requena on 08/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies = [MovieResult]()
    @Published var image = ImageLoader()
    
    init() {
        RequestAPIMovies.loadMovies(page: "1", endPoint: .discover) { (result: Result<Movie, APIServiceError>) in
            switch result {
            case .success(let movies):
                self.movies = movies.results
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}

struct MovieViewModel {
    var movie: MovieResult
    
    init(movie: MovieResult) {
        self.movie = movie
    }
    
    var title: String {
        return self.movie.title ?? ""
    }
    
    var overview: String {
        return self.movie.overview ?? ""
    }
}
