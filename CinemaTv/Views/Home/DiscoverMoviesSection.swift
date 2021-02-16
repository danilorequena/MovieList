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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: HeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, forIndexPath: indexPath)
        header.titleText = "Discover"
        header.titleColor = .white
        
        return header
    }
    
    func numberOfItemsInSection() -> Int {
        movies.count
    }
    
    func register(_ collectionView: UICollectionView) {
        collectionView.register(DiscoverCollectionViewCell.loadNib(), forCellWithReuseIdentifier: DiscoverCollectionViewCell.identifier())
//        collectionView.register(DiscoverCollectionViewCell.self)
    }
    
    func cellSize(with collectionViewBounds: CGRect, at indexPath: IndexPath) -> CGSize {
//        .init(width: collectionViewBounds.width - 132, height: collectionViewBounds.height - 32 )
        .init(width: 280, height: 400)
    }
    
    func headerSize(width: CGFloat, in section: Int) -> CGSize {.zero}
    
    func headerInsets(in section: Int) -> UIEdgeInsets {.zero}
}
