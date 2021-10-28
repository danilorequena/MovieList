//
//  MoviesSearchManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 14/06/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

protocol MoviesSearchManagerDelegate: AnyObject {
    func didTapMovie(indexPath: IndexPath)
}

final class MoviesSearchSection: Section {
    weak var delegate: MoviesSearchManagerDelegate?
    
    private let movies: [ResultDiscover]
    
    init(movies: [ResultDiscover]) {
        self.movies = movies
    }
    
    func numberOfItemsInSection() -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesSearchCell.identifier(), for: indexPath) as! MoviesSearchCell
        let movies = movies[indexPath.item]
        cell.prepareCell(with: movies)
        return cell
    }
    
    func register(_ collectionView: UICollectionView) {
        collectionView.register(MoviesSearchCell.self)
    }
    
    func cellSize(with collectionViewBounds: CGRect, at indexPath: IndexPath) -> CGSize {
        calculateCarouselItemSize(width: collectionViewBounds.width)
    }
    
    func headerSize(width: CGFloat, in section: Int) -> CGSize {
        .zero
    }
    
    func headerInsets(in section: Int) -> UIEdgeInsets {
        .zero
    }
    
    private func calculateCarouselItemSize(width: CGFloat, horizontalInset: CGFloat = 0.0) -> CGSize {
        let totalHorizontalInsets: CGFloat = 40
        let itemWidth = (width - totalHorizontalInsets) / 2
        return .init(width: itemWidth + horizontalInset, height: itemWidth * 1.85)
    }
}

extension MoviesSearchSection: MoviesSearchManagerDelegate {
    func didTapMovie(indexPath: IndexPath) {

        
    }
}
