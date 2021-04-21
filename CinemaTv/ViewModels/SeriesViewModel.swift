//
//  MainViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 07/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

protocol SeriesViewModelProtocol: AnyObject {
    func fetchPopularSeries()
    func fetchSeriesOnAir()
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
    
    func fetchPopularSeries() {
        RequestAPITVShows.loadSeries(
            params: ["page" : "\(popularPage)",
                     "include_adult" : "false",
                     "include_video" : "true",
                     "primary_release_date.gte" : "2018-01-01",
                     "language" : "pt-BR"],
            endpoint: .popular) { (series: PopularSeries) in
            self.seriesPopular += series.results
            self.totalPopular = series.totalResults ?? 0
            self.delegate?.successList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
        
    }
    
    func fetchSeriesOnAir() {
        RequestAPITVShows.loadSeries(
            params: ["page" : "\(seriesOnAirPage)",
                     "include_adult" : "false",
                     "include_video" : "true",
                     "primary_release_date.gte" : "2018-01-01",
                     "language" : "pt-BR"],
            endpoint: .onAir) { (series: SeriesOnAir) in
            self.seriesOnAir += series.results
            self.totalSeriesOnAir = series.totalResults ?? 0
            self.delegate?.successList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
    
    func fetchDiscoverSeries() {
        RequestAPITVShows.loadSeries(
            params: ["sort_by" : "popularity.desc",
                     "include_adult" : "false",
                     "include_video" : "true",
                     "page" : "\(discoverPage)",
                     "primary_release_date.gte" : "2018-01-01",
                     "language" : "pt-BR"],
            endpoint: .discover) { (series: DiscoverSeries) in
            self.discoverSeries += series.results ?? []
            self.delegate?.successList()
        } onError: { (error) in
            self.delegate?.errorList()
        }
    }
}
