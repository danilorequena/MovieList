//
//  ListMoviesSwiftUI.swift
//  CinemaTv
//
//  Created by Danilo Requena on 08/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ListMoviesSwiftUI: View {
    @ObservedObject private var moviesListViewModel = MovieListViewModel()
    @ObservedObject private var imageLoader = ImageLoader()
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Discover Movies")
                .font(.title)
                .padding()
                .foregroundColor(.pink)
            Divider()
            
            List(self.moviesListViewModel.movies, id: \.title) { movies in
                VStack {
                    Text(movies.title ?? "não foi dessa vez")
                        .bold()
                        .padding(.top)
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w200" + movies.posterPath!))
                        .shadow(radius: 7)
                    Spacer()
                    Text(movies.overview ?? "")
                }
            }
        }
    }
}

struct ListMoviesSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        ListMoviesSwiftUI()
    }
}
