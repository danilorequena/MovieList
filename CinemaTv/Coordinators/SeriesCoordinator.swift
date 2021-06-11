//
//  SeriesCoordinator.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 13/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

final class SeriesCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = DiscoverSeriesHomeViewController.instantiateSeries()
        vc.tabBarItem = UITabBarItem(title: "tab.tvShows".localized, image: UIImage(named: "serie"), tag: 1)
        navigationController.pushViewController(vc, animated: false)
    }
}
