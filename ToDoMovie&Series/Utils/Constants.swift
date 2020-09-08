//
//  Constants.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 07/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation


struct Constants {
    //URLs
    static let apiKey = "ddf20e1d6a0147313cfd3b4ac419e373"
    static let basePathMovies = "https://api.themoviedb.org/3/movie/popular?api_key="
    static let basePathPopularSeries = "https://api.themoviedb.org/3/tv/popular?api_key="
    static let basePathLatestSeries = "https://api.themoviedb.org/3/tv/top_rated?api_key="
    static let basePathSeriesOnAir = "https://api.themoviedb.org/3/tv/on_the_air?api_key="
    
    //Cells
    static let seriesTop = "seriesTopCell"
    static let seriesPopular = "seriesCell"
}
