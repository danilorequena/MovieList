//
//  Series.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 02/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let series = try? newJSONDecoder().decode(Series.self, from: jsonData)

import Foundation

// MARK: - Series
struct PopularSeries: Codable {
    let page, totalResults, totalPages: Int?
    let results: [ResultPopularSeries]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct ResultPopularSeries : Codable {
    let originalName: String?
    let genreIDS: [Int]?
    let name: String?
    let popularity: Double?
    let voteCount: Int?
    let firstAirDate, backdropPath: String?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
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

