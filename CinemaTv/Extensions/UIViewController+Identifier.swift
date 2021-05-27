//
//  UIViewController+Identifier.swift
//  CinemaTv
//
//  Created by Danilo Requena on 14/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc
    open var identifier: String {
        return String(describing: classForCoder)
    }
}
