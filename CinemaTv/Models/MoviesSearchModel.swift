//
//  MoviesSearchModel.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/06/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

// MARK: - MoviesSearch
struct MoviesSearchModel: Codable {
    let page, totalResults, totalPages: Int?
    let results: [MoviesSearchResult]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}

// MARK: - Result
struct MoviesSearchResult: Codable {
//    var adult: Bool?
//    var backdropPath: String
//    var genreIDS: [Int]?
//    var id: Int?
//    var originalLanguage: String?
//    var originalTitle, overview: String?
//    var popularity: Double?
//    var posterPath, releaseDate, title: String?
//    var video: Bool?
//    var voteAverage: Double?
//    var voteCount: Int?
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath, originalLanguage, originalTitle: String
    let genreIDS: [Int]?
    let title: String?
    let voteAverage: Double?
    let overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}

