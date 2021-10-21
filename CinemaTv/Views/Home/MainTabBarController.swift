//
//  MainTabBarController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 13/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    let main = MainCoordinator(navigationController: UINavigationController())
    let serieCoord = SeriesCoordinator(navigationController: UINavigationController())
    let favoriteCoord = FavoritesCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        main.start()
        serieCoord.start()
        favoriteCoord.start()
        viewControllers = [main.navigationController, serieCoord.navigationController, favoriteCoord.navigationController]
        self.tabBar.barTintColor = #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.isTranslucent = true
    }
}
