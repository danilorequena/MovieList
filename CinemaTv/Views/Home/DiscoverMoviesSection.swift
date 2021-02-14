//
//  DiscoverMoviesSection.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

final class DiscoverMoviesSection: Section {
    let movies: [ResultDiscover]
    
    init(movies: [ResultDiscover]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCollectionViewCell.identifier(), for: indexPath) as! DiscoverCollectionViewCell
        let movies = self.movies[indexPath.item]
        cell.setupCell(movie: movies)
        return cell
    }
    
    func numberOfItemsInSection() -> Int {
        movies.count
    }
    
    func register(_ collectionView: UICollectionView) {
        collectionView.register(DiscoverCollectionViewCell.loadNib(), forCellWithReuseIdentifier: DiscoverCollectionViewCell.identifier())
    }
    
    func cellSize(with collectionViewBounds: CGRect, at indexPath: IndexPath) -> CGSize {
        .init(width: collectionViewBounds.width - 132, height: collectionViewBounds.height - 32 )
    }
    
    func headerSize(width: CGFloat, in section: Int) -> CGSize {.zero}
    
    func headerInsets(in section: Int) -> UIEdgeInsets {.zero}
}
