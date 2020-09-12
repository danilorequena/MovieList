//
//  SeriesOnAir.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 07/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation

// MARK: - SeriesOnAir
struct SeriesOnAir: Codable {
    let page, totalResults, totalPages: Int?
    let results: [ResultSeriesOnAir]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct ResultSeriesOnAir: Codable {
    let originalName: String?
    let genreIDS: [Int]?
    let name: String?
    let popularity: Double?
//    let originCountry: [OriginCountry]?
    let voteCount: Int?
    let firstAirDate: String?
    let backdropPath: String?
//    let originalLanguage: OriginalLanguage?
    let id: Int?
    let voteAverage: Double?
    let overview, posterPath: String?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
//        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
//        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}

//enum OriginCountry: String, Codable {
//    case ca = "CA"
//    case de = "DE"
//    case jp = "JP"
//    case us = "US"
//}

//enum OriginalLanguage: String, Codable {
//    case de = "de"
//    case en = "en"
//    case fr = "fr"
//    case ja = "ja"
//}
