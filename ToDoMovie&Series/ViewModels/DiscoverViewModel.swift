//
//  DiscoverViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 26/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation


protocol DiscoverProtocol: AnyObject {
    func fetchDiscoverMovies()
}

protocol DiscoverViewModelDelegate: AnyObject {
    func successDiscoverList()
    func errorList()
}

class DiscoverViewModel: DiscoverProtocol {
    var delegate: DiscoverViewModelDelegate?
    var movies: [ResultDiscover] = []
    
    func fetchDiscoverMovies() {
        RequestAPI.loadDiscoverMovies { (movies) in
            self.movies += movies?.results ?? []
            self.delegate?.successDiscoverList()
        } onError: { (error) in
            self.delegate?.errorList()
        }

    }
}
