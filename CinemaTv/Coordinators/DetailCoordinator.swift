//
//  DetailCoordinator.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 08/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

class DetailCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var seriesPop: ResultSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var discoverSeries: ResultDiscoverSeries?
    
    
    init(navigationController: UINavigationController,
         discoverMovies: ResultDiscover? = nil,
         popSeries: ResultSeries? = nil,
         onAirSeries: ResultSeriesOnAir? = nil,
         discoverSeries: ResultDiscoverSeries? = nil) {
        self.navigationController = navigationController
        self.discoverMovies = discoverMovies
        self.seriesPop = popSeries
        self.seriesOnAir = onAirSeries
        self.discoverSeries = discoverSeries
    }
    
    func start() {
        let vc = DetailViewController.instantiateDetail()
        vc.discoverMovies = discoverMovies
        vc.seriesPop = seriesPop
        vc.discoverSeries = discoverSeries
        if discoverMovies != nil {
            vc.titleNavigation = discoverMovies?.originalTitle
        } else if seriesPop != nil {
            vc.titleNavigation = seriesPop?.originalName
        } else if seriesOnAir != nil {
            vc.titleNavigation = seriesOnAir?.originalName
        } else if discoverSeries != nil {
            vc.titleNavigation = discoverSeries?.originalName
        }
        vc.seriesOnAir = seriesOnAir
        navigationController.pushViewController(vc, animated: true)
    }
}
