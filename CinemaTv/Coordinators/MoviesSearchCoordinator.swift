//
//  FavoritesCoordinator.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

class MoviesSearchCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

    }
    
    func start() {
        navigationController.delegate = self
        let vc = MoviesSearchViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
