//
//  MainViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 07/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

protocol SeriesViewModelProtocol: AnyObject {
    func fetchSeries()
    func fetchPopularSeries()
    func fetchSeriesOnAir()
    func fetchDiscoverSeries()
}

protocol MainViewModelDelegate: AnyObject {
    func successList()
    func errorList()
}

final class SeriesViewModel: SeriesViewModelProtocol {
    var seriesPopular: [ResultPopularSeries] = []
    var seriesTopRated: [ResultTopRated] = []
    var seriesOnAir: [ResultSeriesOnAir] = []
    var discoverSeries: [ResultDiscoverSeries] = []
    weak var delegate: MainViewModelDelegate?
    var totalPopular = 0
    var totalDiscover = 0
    var discoverPage = 1
    var totalTopRated = 0
    var totalSeriesOnAir = 0
    var popularPage = 1
    var topRatedPage = 0
    var seriesOnAirPage = 1
    let group = DispatchGroup()
    
    func fetchSeries() {
        group.enter()
        fetchPopularSeries()
        group.leave()
        
        group.enter()
        fetchDiscoverSeries()
        group.leave()
        
        group.enter()
        fetchSeriesOnAir()
        group.leave()
    }
    
    func fetchPopularSeries() {
        RequestAPITVShows.loadSeries(
            params: [
                "page" : "\(popularPage)",
                "include_adult" : "false",
                "include_video" : "true",
                "primary_release_date.gte" : "2018-01-01",
                "language" : "pt-BR"
            ],
            endpoint: .popular) { (result: Result<PopularSeries, APIServiceError>) in
            switch result {
            case let .success(series):
                self.seriesPopular += series.results
                self.totalPopular = series.totalResults ?? 0
                self.delegate?.successList()
            case .failure:
                self.delegate?.errorList()
            }
        }
    }
    
    func fetchSeriesOnAir() {
        RequestAPITVShows.loadSeries(
            params: [
                "page" : "\(seriesOnAirPage)",
                "include_adult" : "false",
                "include_video" : "true",
                "primary_release_date.gte" : "2018-01-01",
                "language" : "pt-BR"
            ],
            endpoint: .onAir) { (result: Result<SeriesOnAir, APIServiceError>) in
            switch result {
            case let .success(series):
                self.seriesOnAir += series.results
                self.totalSeriesOnAir = series.totalResults ?? 0
                self.delegate?.successList()
            case .failure:
                self.delegate?.errorList()
            }
        }
    }
    
    func fetchDiscoverSeries() {
        RequestAPITVShows.loadSeries(
            params: [
                "sort_by" : "popularity.desc",
                "include_adult" : "false",
                "include_video" : "true",
                "page" : "\(discoverPage)",
                "primary_release_date.gte" : "2018-01-01",
                "language" : "pt-BR"
            ],
            endpoint: .discover) { (result: Result<DiscoverSeries, APIServiceError>) in
            switch result {
            case let .success(series):
                self.discoverSeries += series.results ?? []
                self.delegate?.successList()
            case .failure:
                self.delegate?.errorList()
            }
        }
    }
}
