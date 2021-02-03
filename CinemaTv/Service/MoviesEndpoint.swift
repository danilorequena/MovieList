//
//  Endpoint.swift
//  CinemaTv
//
//  Created by Danilo Requena on 31/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation

enum MoviesEndpoint {
    case popular, toRated, upcoming, nowPlaying
    case detail(movie: Int), recommended(movie: Int), similar(movie: Int)
    case credits(movie: Int), review(movie: Int)
    case searchMovie, searchKeyword
    case genres
    case discover
    
    func path() -> String {
        switch self {
        case .popular:
            return "movie/popular"
        case .toRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
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
            return "discover/movie"
        }
    }
}
