//
//  DiscoverSeries.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 10/11/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

// MARK: - DiscoverSeries
struct DiscoverSeries: Codable {
    let page, totalResults, totalPages: Int?
    let results: [ResultDiscoverSeries]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct ResultDiscoverSeries: Codable {
    let originalName: String?
    let name: String?
    let popularity: Double?
    let voteCount: Int?
    let firstAirDate: String?
    let backdropPath: String?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case name, popularity
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}

