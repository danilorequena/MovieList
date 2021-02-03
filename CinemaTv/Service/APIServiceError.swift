//
//  APIServiceError.swift
//  CinemaTv
//
//  Created by Danilo Requena on 02/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}
