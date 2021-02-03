//
//  NetworkProtocol.swift
//  CinemaTv
//
//  Created by Danilo Requena on 31/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

protocol NetworkProtocol: class {
    func get<T: Decodable>(url: String, response: T.Type, completion: @escaping (Bool, T?)->Void)
    func post<T: Decodable, EncodableType: Encodable>(url: String, params: EncodableType?, response: T.Type, completion: @escaping (Bool, T?)->Void)
}
