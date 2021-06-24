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
    private var movies: MoviesSearchModel?
    
    private weak var delegate: MoviesSearchViewModelDelegate?
    
    func fetchSearch(movie: String) {
        MoviesSearchService.loadMoviesSeach(page: "1", movie: movie, endpoint: .searchKeyword) { (result: Result<MoviesSearchModel, APIServiceError>) in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.delegate?.successSearch()
            case .failure:
                self.delegate?.errorSearch()
            }
        }
    }
    
    
}
