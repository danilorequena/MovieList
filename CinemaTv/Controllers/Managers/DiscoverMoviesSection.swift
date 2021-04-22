//
//  DiscoverMoviesSection.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

protocol DiscoverMoviesSectionDelegate: AnyObject {
    func didTapCell(indexPath: IndexPath)
}

final class DiscoverMoviesSection: Section {
    weak var delegate: DiscoverMoviesSectionDelegate?
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapCell(indexPath: indexPath)
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
