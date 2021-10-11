//
//  MoviesSearchViewModel.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/06/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

protocol MoviesSearchViewModelDelegate: AnyObject {
    func successSearch()
    func errorSearch()
}

protocol MoviesSearchViewModelProtocol: AnyObject{
    func fetchSearch(movie: String)
}

final class MoviesSearchViewModel: MoviesSearchViewModelProtocol {
    var movies: [ResultDiscover] = []
    
    weak var delegate: MoviesSearchViewModelDelegate?
    
    func fetchSearch(movie: String) {
        MoviesSearchService.loadMoviesSeach(page: "1", movie: movie, endpoint: .searchMovie) { (result: Result<DiscoverMovies, APIServiceError>) in
            switch result {
            case .success(let movies):
                self.movies = movies.results ?? []
                self.delegate?.successSearch()
            case .failure(let error):
                print(error)
                self.delegate?.errorSearch()
            }
        }
    }
    
    
}
