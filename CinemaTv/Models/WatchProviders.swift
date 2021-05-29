//
//  WatchProviders.swift
//  CinemaTv
//
//  Created by Danilo Requena on 28/05/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

// MARK: - WatchProviders
struct WatchProviders: Codable {
    let id: Int
    let results: WatchProvidersResults
}

// MARK: - Results
struct WatchProvidersResults: Codable {
//    let br, us, ar, gb: Region
    let US: US
}

struct Region: Codable {
    let link: String
    let buy: [ProvidersData]
    let flatrate: [ProvidersData]?
    let rent: [ProvidersData]
}


struct US: Codable {
    let link: String
    let buy: [ProvidersData]?
    let flatrate: [ProvidersData]?
    let rent: [ProvidersData]?
}

struct BR: Codable {
    let link: String
    let buy: [ProvidersData]
    let rent: [ProvidersData]
}

struct AR: Codable {
    let link: String
    let buy: [ProvidersData]
    let rent: [ProvidersData]
}

struct GB: Codable {
    let link: String
    let buy: [ProvidersData]
    let flatrate: [ProvidersData]
    let rent: [ProvidersData]
}

struct ProvidersData: Codable {
    let logoPath, providerName: String?
    
    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerName = "provider_names"
    }
}
