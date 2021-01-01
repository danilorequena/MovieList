//
//  UIView+Extension.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 07/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

extension UIView {
    func shadowDefault() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
    }
}
