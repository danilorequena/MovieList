//
//  DescribeProtocol.swift
//  CinemaTv
//
//  Created by Danilo Requena on 14/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

public protocol DescribeProtocol: AnyObject {}

extension DescribeProtocol where Self: NSObject {
    public static var identifier: String {
        return String(describing: self)
    }
}
