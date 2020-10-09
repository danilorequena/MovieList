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
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DetailMoviesViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
}
