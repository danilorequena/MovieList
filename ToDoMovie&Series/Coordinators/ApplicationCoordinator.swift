//
//  ApplicationCoordinator.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 26/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
//   let kanjiStorage: KanjiStorage  // 1
  let window: UIWindow   // 2
  let rootViewController: UINavigationController   // 3
  
  init (window: UIWindow ) { // 4
    self .window = window
//    kanjiStorage = KanjiStorage ()
    rootViewController = UINavigationController ()
    rootViewController.navigationBar.prefersLargeTitles = true
    
    // O código abaixo é para fins de teste // 5
    let mainViewController = DiscoverMoviesViewController()
//    emptyViewController.view.backgroundColor = .cyan
    rootViewController.pushViewController (mainViewController, animated: false )
  }
  
  func  start() {   // 6
    window.rootViewController = rootViewController
    window.makeKeyAndVisible ()
  }
}
