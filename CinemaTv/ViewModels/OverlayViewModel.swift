//
//  OverlayViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 23/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

protocol OverlayViewModelProtocol: AnyObject {
    func fetchCastMovies(id: Int)
    func fetchWatchProviders(id: Int)
}

protocol OverlayViewModelDelegate: AnyObject {
    func successList()
    func errorList()
}

class OverlayViewModel: OverlayViewModelProtocol {
    var infos: ResultPopularSeries?
    var details: PopularSeriesDetails?
    var createdBy: [CreatedBy] = []
    var genre: [Genre] = []
    var providers: US?
    var season: [Season] = []
    var cast: [CastElement] = []
    weak var delegate: OverlayViewModelDelegate?
    
    func fetchCastMovies(id: Int) {
        RequestCastService.loadMoviesCast(endpoint: .credits(movie: id)) { [weak self] (movies: Cast) in
            guard let self = self else { return }
            self.cast = movies.cast ?? []
            self.delegate?.successList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
    
    func fetchSeriesCast(id: Int) {
        RequestCastService.loadSeriesCast(endpoint: .credits(tvID: id)) { [weak self] (series: Cast) in
            guard let self = self else { return }
            self.cast += series.cast ?? []
            self.delegate?.successList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
    
    func fetchWatchProviders(id: Int) {
        WatchProvidersService.loadProviders(endPoint: .watchProviders(movieID: id)) { [weak self] (providers: WatchProviders) in
            guard let self = self else { return }
            self.providers = providers.results.US
            self.delegate?.successList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
}

