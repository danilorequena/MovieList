//
//  FavoritesCoordinator.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

class FavoritesCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

    }
    
    func start() {
        navigationController.delegate = self
        let vc = FavoritesMoviesViewController()
        vc.tabBarItem = UITabBarItem(title: "favorites", image: UIImage(systemName: "heart.fill"), tag: 2)
        navigationController.pushViewController(vc, animated: true)
    }
}
