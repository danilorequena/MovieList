//
//  DiscoverSeriesHomeManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 18/04/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class DiscoverSeriesHomeManager: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    var discoverSeries: [ResultDiscoverSeries]
    var navigationController: UINavigationController
    var viewModel: SeriesViewModel
    
    init(
        discoverSeries: [ResultDiscoverSeries],
        navigationController: UINavigationController,
        viewModel: SeriesViewModel
    ) {
        self.discoverSeries = discoverSeries
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        discoverSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(DiscoverSeriesCollectionViewCell.loadNib(), forCellWithReuseIdentifier: DiscoverSeriesCollectionViewCell.identifier())
        let series = discoverSeries[indexPath.item]
        let cell: DiscoverSeriesCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setupCell(tvShow: series)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let series = discoverSeries[indexPath.item]
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.detailDiscoverSeries(discoverSeries: series)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (discoverSeries.count) - 10 {
            viewModel.discoverPage += 1
            viewModel.fetchDiscoverSeries()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 182, height: 261)
    }
}
