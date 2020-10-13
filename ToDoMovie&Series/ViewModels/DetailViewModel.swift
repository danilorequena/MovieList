//
//  DetailViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 12/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewModelProtocol: AnyObject {
    func fetchDetailsSeries(id: Int)
}

class DetailViewModel: DetailViewModelProtocol {
    
    var seriesPop: ResultSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var createdBy: [CreatedBy] = []
    var genre: [Genre] = []
    var networks: [Network] = []
    var season: [Season] = []
    
    func fetchDetailsSeries(id: Int) {
        RequestAPI.loadPopularSeriesDetails(id: id) { (series) in
            self.createdBy += series?.createdBy ?? []
            self.genre += series?.genres ?? []
            self.networks += series?.networks ?? []
            self.season += series?.seasons ?? []
        } onError: { (error) in
            print(error)
        }
    }
}
