//
//  DiscoverViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 26/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit


protocol DiscoverProtocol: AnyObject {
    func fetchDiscoverMovies()
}

protocol DiscoverViewModelDelegate: AnyObject {
    func successDiscoverList()
    func errorList()
}

class DiscoverViewModel: DiscoverProtocol, ObservableObject {
    weak var delegate: DiscoverViewModelDelegate?
    @Published var discoverMovies: [ResultDiscover] = []
    @Published var topRatedMovies: [MovieResult] = []
    var discoverPage = 1
    var topRatedPage = 1
    let group = DispatchGroup()
    
    func fetchMovies() {
        group.enter()
        fetchDiscoverMovies()
        group.leave()
        
        group.enter()
        fetchTopRatedMovies()
        group.leave()
    }
    
    func fetchDiscoverMovies() {
        RequestAPIMovies.loadMovies(
            page: "\(discoverPage)",
            endPoint: .discover
        ) { (result: Result<DiscoverMovies, APIServiceError>) in
            switch result {
            case .success(let movies):
                self.discoverMovies += movies.results ?? []
                self.delegate?.successDiscoverList()
            case .failure:
                self.delegate?.errorList()
            }
        }
    }

    func fetchTopRatedMovies() {
        RequestAPIMovies.loadMovies(
            page: "\(topRatedPage)",
            endPoint: .toRated
        ) { (result: Result<Movie, APIServiceError>) in
            switch result {
            case .success(let movies):
                self.topRatedMovies += movies.results
                self.delegate?.successDiscoverList()
            case .failure:
                self.delegate?.errorList()
            }
        }
    }
    
    func configureNavigate(controller: UIViewController) {
        controller.configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "Movies", preferredLargeTitle: true)
    }
}
