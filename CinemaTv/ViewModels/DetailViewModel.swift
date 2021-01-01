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
    func fetchDetails(id: Int)
}

class DetailViewModel: DetailViewModelProtocol {
    
    var seriesPop: ResultSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var createdBy: [CreatedBy] = []
    var genre: [Genre] = []
    var networks: [Network] = []
    var season: [Season] = []
    
    func fetchDetails(id: Int) {
        RequestAPITVShows.loadPopularSeriesDetails(id: id) { (series) in
            self.createdBy += series?.createdBy ?? []
            self.genre += series?.genres ?? []
            self.networks += series?.networks ?? []
            self.season += series?.seasons ?? []
        } onError: { (error) in
            print(error)
        }
    }
    
    func setNavigation(controller: UIViewController, title: String) {
        controller.configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: title, preferredLargeTitle: true)
    }
}
