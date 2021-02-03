//
//  SeriesEndpoint.swift
//  CinemaTv
//
//  Created by Danilo Requena on 02/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

enum SeriesEndpoint {
    case popular, onAir, topRated, nowPlaying
    case detail(movie: Int), recommended(movie: Int), similar(movie: Int)
    case credits(movie: Int), review(movie: Int)
    case searchMovie, searchKeyword
    case genres
    case discover
    
    func path() -> String {
        switch self {
        case .popular:
            return "tv/popular"
        case .onAir:
            return "tv/on_the_air"
        case .topRated:
            return "tv/top_rated"
        case .nowPlaying:
            return "movie/now_playing"
        case let .detail(movie):
            return "movie/\(String(movie))"
        case let .credits(movie):
            return "movie/\(String(movie))/credits"
        case let .review(movie):
            return "movie/\(String(movie))/reviews"
        case let .recommended(movie):
            return "movie/\(String(movie))/recommendations"
        case let .similar(movie):
            return "movie/\(String(movie))/similar"
        case .searchMovie:
            return "search/movie"
        case .searchKeyword:
            return "search/keyword"
        case .genres:
            return "genre/movie/list"
        case .discover:
            return "discover/tv"
        }
    }
}

