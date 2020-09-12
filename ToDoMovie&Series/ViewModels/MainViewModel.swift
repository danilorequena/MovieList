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
    func fetchSeriesOnAir()
}

protocol MainViewModelDelegate: AnyObject {
    func successListPopular()
    func successListOnAir()
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
    var popularPage = 1
    var topRatedPage = 0
    var seriesOnAirPage = 1
    
    func fetchPopularSeries() {
        RequestAPI.loadPopularSeries(url: "\(Constants.basePathPopularSeries)\(popularPage)", onComplete: { (serie) in
            if let serie = serie {
                self.seriesPopular += serie.results
                self.totalPopular = serie.totalResults ?? 0
                print("Total: \(self.totalPopular)", "Inclusos: \(self.seriesPopular.count)" )
                self.delegate?.successListPopular()
            }
        }) { (error) in
            self.delegate?.errorList()
        }
    }
    
//    func fetchOnAirSeries() {
//        RequestAPI.loadTopRatedSeries(onComplete: { (serie) in
//            if let serie = serie {
//                self.seriesTopRated += serie.results
//                self.totalTopRated = serie.totalResults ?? 0
//                print("Total: \(self.totalTopRated)")
//                self.delegate?.successListPopular()
//            }
//        }) { (error) in
//            self.delegate?.errorList()
//        }
//    }
    
    func fetchSeriesOnAir() {
        RequestAPI.loadSeriesOnAir(url:"\(Constants.basePathSeriesOnAir)\(seriesOnAirPage)" ,onComplete: { (seriesOnAir) in
            if let seriesOnAir = seriesOnAir {
                self.seriesOnAir += seriesOnAir.results
                self.totalSeriesOnAir = seriesOnAir.totalResults ?? 0
                print("Total: \(self.totalSeriesOnAir)")
                self.delegate?.successListOnAir()
            }
        }) { (error) in
            self.delegate?.errorList()
        }
    }
}
