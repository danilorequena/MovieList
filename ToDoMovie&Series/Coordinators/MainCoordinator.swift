//
//  MainCoordinator.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 26/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = DiscoverViewController.instantiate()
        vc.tabBarItem = UITabBarItem(title: "tab.discover".loalized, image: UIImage(named: "movie"), tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func detail(discoverMovies: ResultDiscover) {
        let child = DetailCoordinator(navigationController: navigationController, discoverMovies: discoverMovies)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let detailViewController = fromViewController as? DetailViewController {
            childDidFinish(detailViewController.coordinator)
        }
    }
}
