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
    
    
    init(navigationController: UINavigationController, discoverMovies: ResultDiscover? = nil, popSeries: ResultSeries? = nil, onAirSeries: ResultSeriesOnAir? = nil ) {
        self.navigationController = navigationController
        self.discoverMovies = discoverMovies
        self.seriesPop = popSeries
        self.seriesOnAir = onAirSeries
    }
    
    func start() {
        let vc = DetailViewController.instantiateDetail()
        vc.discoverMovies = discoverMovies
        vc.seriesPop = seriesPop
        if discoverMovies != nil {
            vc.titleNavigation = discoverMovies?.originalTitle
        } else if seriesPop != nil {
            vc.titleNavigation = seriesPop?.originalName
        } else if seriesOnAir != nil {
            vc.titleNavigation = seriesOnAir?.originalName
        }
        vc.seriesOnAir = seriesOnAir
        navigationController.pushViewController(vc, animated: true)
    }
}
