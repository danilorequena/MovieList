//
//  UIView+DropShadow.swift
//  CinemaTv
//
//  Created by Danilo Requena on 22/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

extension UIView {
    public func dropShadow(offset: CGSize = CGSize(width: -2, height: 2),
                           radius: CGFloat = 4,
                           opacity: Float = 0.5,
                           color: CGColor = UIColor.black.cgColor) {
        layer.shadowColor = color
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}
