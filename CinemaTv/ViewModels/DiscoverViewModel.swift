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
    @Published var topRatedMovies: [Result] = []
    var discoverPage = 1
    var topRatedPage = 1
    
    func fetchMovies() {
        fetchDiscoverMovies()
        fetchTopRatedMovies()
    }
    
    func fetchDiscoverMovies() {
        RequestAPIMovies.loadMovies(page: "\(discoverPage)",endPoint: .discover) { (movies: DiscoverMovies) in
            self.discoverMovies += movies.results ?? []
            self.delegate?.successDiscoverList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
    
    func fetchTopRatedMovies() {
        RequestAPIMovies.loadMovies(page: "\(topRatedPage)",endPoint: .toRated) { (movies: Movie) in
            self.topRatedMovies += movies.results
            self.delegate?.successDiscoverList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
    
    func configureNavigate(controller: UIViewController) {
        controller.configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "Movies", preferredLargeTitle: true)
    }
}
