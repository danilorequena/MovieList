//
//  PopularSeriesManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/04/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class PopularSeriesManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var popularSeries: [ResultPopularSeries]
    var navigationController: UINavigationController
    var viewModel: SeriesViewModel
    
    init(
        popularSeries: [ResultPopularSeries],
        navigationController: UINavigationController,
        viewModel: SeriesViewModel
    ) {
        self.popularSeries = popularSeries
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(PopularCollectionViewCell.loadNib(), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier())
        let serie = popularSeries[indexPath.item]
        let cell: PopularCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.prepareCell(with: serie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let serie = popularSeries[indexPath.item]
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.detailPopularSeries(popSeries: serie)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (popularSeries.count) - 10 {
            viewModel.popularPage += 1
            viewModel.fetchPopularSeries()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 150, height: 200)
    }
}
