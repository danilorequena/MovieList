//
//  OverlayViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 23/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

protocol OverlayViewModelProtocol: AnyObject {
    func fetchDetailsSeries(id: Int)
    func fetchCastMovies(id: Int)
}

protocol OverlayViewModelDelegate: AnyObject {
    func successList()
    func errorList()
}

class OverlayViewModel: OverlayViewModelProtocol {
    var infos: ResultSeries?
    var details: PopularSeriesDetails?
    var createdBy: [CreatedBy] = []
    var genre: [Genre] = []
    var networks: [Network] = []
    var season: [Season] = []
    var cast: [CastElement] = []
    weak var delegate: OverlayViewModelDelegate?
    
    func fetchDetailsSeries(id: Int) {
        RequestAPITVShows.loadPopularSeriesDetails(id: id) { (series) in
            self.createdBy += series?.createdBy ?? []
            self.genre += series?.genres ?? []
            self.networks += series?.networks ?? []
            self.season += series?.seasons ?? []
            self.details = series
            self.delegate?.successList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
    
    func fetchCastMovies(id: Int) {
        
        RequestCastService.loadMoviesCast(endpoint: .credits(movie: id)) { (movies: Cast) in
            self.cast += movies.cast ?? []
            self.delegate?.successList()
        } onError: { (error) in
            self.delegate?.errorList()
        }

    }
    
    func fetchSeriesCast(id: Int) {
        RequestCastService.loadSeriesCast(endpoint: .credits(tvID: id)) { (series: Cast) in
            self.cast += series.cast ?? []
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
}

