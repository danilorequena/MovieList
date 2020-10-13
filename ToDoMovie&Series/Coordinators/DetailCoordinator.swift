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
    
    
    init(navigationController: UINavigationController, discoverMovies: ResultDiscover?) {
        self.navigationController = navigationController
        self.discoverMovies = discoverMovies
    }
    
    func start() {
        let vc = DetailViewController.instantiateDetail()
        vc.discoverMovies = discoverMovies
        navigationController.pushViewController(vc, animated: true)
    }
}
