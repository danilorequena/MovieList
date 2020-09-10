//
//  MainViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 07/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    func fetchPopularSeries()
//    func fetchTopRatedSeries()
    func fetchSeriesOnAir()
}

protocol MainViewModelDelegate: AnyObject {
    func successList()
    func errorList()
}

class MainViewModel: MainViewModelProtocol {
    var seriesPopular: [ResultSeries] = []
    var seriesTopRated: [ResultTopRated] = []
    var seriesOnAir: [ResultSeriesOnAir] = []
    weak var delegate: MainViewModelDelegate?
    var totalPopular = 0
    var totalTopRated = 0
    var totalSeriesOnAir = 0
    var popularPage = 0
    var topRatedPage = 0
    var seriesOnAirPage = 0
    
    func fetchPopularSeries() {
        RequestAPI.loadPopularSeries(onComplete: { (serie) in
            if let serie = serie {
                self.seriesPopular += serie.results
                self.totalPopular = serie.totalResults ?? 0
                self.popularPage = serie.totalPages ?? 0
                print("Total: \(self.totalPopular)", "Inclusos: \(self.seriesPopular.count)" )
                self.delegate?.successList()
            }
        }) { (error) in
            self.delegate?.errorList()
        }
    }
    
    func fetchOnAirSeries() {
        RequestAPI.loadTopRatedSeries(onComplete: { (serie) in
            if let serie = serie {
                self.seriesTopRated += serie.results
                self.totalTopRated = serie.totalResults ?? 0
                self.topRatedPage = serie.totalPages ?? 0
                print("Total: \(self.totalTopRated)")
                self.delegate?.successList()
            }
        }) { (error) in
            self.delegate?.errorList()
        }
    }
    
    func fetchSeriesOnAir() {
        RequestAPI.loadSeriesOnAir(onComplete: { (seriesOnAir) in
            if let seriesOnAir = seriesOnAir {
                self.seriesOnAir += seriesOnAir.results
                self.totalSeriesOnAir = seriesOnAir.totalResults ?? 0
                self.seriesOnAirPage = seriesOnAir.totalPages ?? 0
                print("Total: \(self.totalSeriesOnAir)")
                self.delegate?.successList()
            }
        }) { (error) in
            self.delegate?.errorList()
        }
    }
}
