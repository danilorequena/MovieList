//
//  Videos.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 12/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

// MARK: - Videos
struct Videos: Codable {
    let id: Int?
    let results: [ResultVideos]?
}

// MARK: - Result
struct ResultVideos: Codable {
    let id, iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
