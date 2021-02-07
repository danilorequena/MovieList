//
//  MainTabBarController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 13/10/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    let main = MainCoordinator(navigationController: UINavigationController())
    let serieCoord = SeriesCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        main.start()
        serieCoord.start()
        viewControllers = [main.navigationController, serieCoord.navigationController]
        self.tabBar.barTintColor = #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.layer.cornerRadius = 16
        self.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBar.layer.shadowOpacity = 0.1
        self.tabBar.layer.shadowOffset = .zero
        self.tabBar.clipsToBounds = true
    }
}
