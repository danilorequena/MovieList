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
    case detail(tvID: Int), recommended(tvID: Int), similar(tvID: Int)
    case credits(tvID: Int), review(tvID: Int)
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
            return "tv/now_playing"
        case let .detail(tvID):
            return "tv/\(String(tvID))"
        case let .credits(tvID):
            return "tv/\(String(tvID))/credits"
        case let .review(tvID):
            return "tv/\(String(tvID))/reviews"
        case let .recommended(tvID):
            return "tv/\(String(tvID))/recommendations"
        case let .similar(tvID):
            return "tv/\(String(tvID))/similar"
        case .searchMovie:
            return "search/tv"
        case .searchKeyword:
            return "search/keyword"
        case .genres:
            return "genre/tv/list"
        case .discover:
            return "discover/tv"
        }
    }
}

