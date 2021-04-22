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
    var seriesPop: ResultPopularSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var discoverSeries: ResultDiscoverSeries?
    var viewModel: DetailViewModel
    
    
    init(
        navigationController: UINavigationController,
        discoverMovies: ResultDiscover? = nil,
        popSeries: ResultPopularSeries? = nil,
        onAirSeries: ResultSeriesOnAir? = nil,
        discoverSeries: ResultDiscoverSeries? = nil,
        viewModel: DetailViewModel
    ) {
        self.navigationController = navigationController
        self.discoverMovies = discoverMovies
        self.seriesPop = popSeries
        self.seriesOnAir = onAirSeries
        self.discoverSeries = discoverSeries
        self.viewModel = viewModel
    }
    
    func start() {
        let vc = DetailViewController(
            discoverMovies: discoverMovies,
            seriesPop: seriesPop,
            seriesOnAir: seriesOnAir,
            discoverSeries: discoverSeries,
            viewModel: viewModel
        )
        
        if discoverMovies != nil {
            vc.titleNavigation = discoverMovies?.originalTitle
        } else if seriesPop != nil {
            vc.titleNavigation = seriesPop?.originalName
        } else if seriesOnAir != nil {
            vc.titleNavigation = seriesOnAir?.originalName
        } else if discoverSeries != nil {
            vc.titleNavigation = discoverSeries?.originalName
        }
        navigationController.pushViewController(vc, animated: true)
    }
}
