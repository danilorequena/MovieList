//
//  LatestSeries.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 05/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

// MARK: - TopRatedSeries
struct TopRatedSeries: Codable {
    let page, totalResults, totalPages: Int?
    let results: [ResultTopRated]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - ResultTopRated
struct ResultTopRated: Codable {
    let originalName: String?
    let genreIDS: [Int]?
    let name: String?
    let popularity: Double?
    let originCountry: [String]?
    let voteCount: Int?
    let firstAirDate: String?
    let backdropPath: String?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}
