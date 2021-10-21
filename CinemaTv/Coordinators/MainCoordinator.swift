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
        let vc = LoginViewController()
        vc.tabBarItem = UITabBarItem(title: "tab.discover".localized, image: UIImage(named: "movie"), tag: 0)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func userLogged() {
        navigationController.delegate = self
        let viewModel = DiscoverViewModel()
        let vc = DiscoverMoviesHomeViewController(viewModel: viewModel)
        vc.tabBarItem = UITabBarItem(title: "tab.discover".localized, image: UIImage(named: "movie"), tag: 0)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func favoritesMovies() {
        let child = FavoritesCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.start()
    }
    
    func searchMovies() {
        let child = MoviesSearchCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.start()
    }
    
    func detailDiscover(discoverMovies: ResultDiscover) {
        let child = DetailCoordinator(
            navigationController: navigationController,
            discoverMovies: discoverMovies,
            viewModel: DetailViewModel())
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func detailDiscoverPop(discoverMovies: MovieResult) {
        let child = DetailCoordinator(
            navigationController: navigationController,
            movie: discoverMovies,
            viewModel: DetailViewModel()
        )
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func detailPopularSeries(popSeries: ResultPopularSeries) {
        let child = DetailCoordinator(
            navigationController: navigationController,
            popSeries: popSeries,
            viewModel: DetailViewModel()
        )
        
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func detailSeriesOnAir(onAirSeries: ResultSeriesOnAir) {
        let child = DetailCoordinator(
            navigationController: navigationController,
            onAirSeries: onAirSeries,
            viewModel: DetailViewModel()
        )
        
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func detailDiscoverSeries(discoverSeries: ResultDiscoverSeries) {
        let child = DetailCoordinator(
            navigationController: navigationController,
            discoverSeries: discoverSeries,
            viewModel: DetailViewModel()
        )
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
