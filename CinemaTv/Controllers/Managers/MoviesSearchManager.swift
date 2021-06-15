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

final class MoviesSearchManager: Section {
    weak var delegate: MoviesSearchManagerDelegate?
    
    let movies: MoviesSearchModel
    
    init(movies: MoviesSearchModel) {
        self.movies = movies
    }
    
    func numberOfItemsInSection() -> Int {
        return movies.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func register(_ collectionView: UICollectionView) {
        
    }
    
    func cellSize(with collectionViewBounds: CGRect, at indexPath: IndexPath) -> CGSize {
        return .init(width: 100, height: 100)
    }
    
    func headerSize(width: CGFloat, in section: Int) -> CGSize {
        .init(width: 0, height: 0)
    }
    
    func headerInsets(in section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(inset: 0)
    }
}

extension MoviesSearchManager: MoviesSearchManagerDelegate {
    func didTapMovie(indexPath: IndexPath) {
        
    }
}
