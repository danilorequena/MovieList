//
//  Storyboarded.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 26/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboaded {
    static func instantiate() -> Self
}

extension Storyboaded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "home.discover".localized, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
    static func instantiateDetail() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "home.detail".localized, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
    static func instantiateSeries() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "home.series".localized, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
