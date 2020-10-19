//
//  SeriesCoordinator.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 13/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

class SeriesCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = HomeSeriesViewController.instantiateSeries()
        vc.tabBarItem = UITabBarItem(title: "tab.tvShows".loalized, image: UIImage(named: "serie"), tag: 1)
        navigationController.pushViewController(vc, animated: false)
    }
}
