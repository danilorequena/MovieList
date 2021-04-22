//
//  OnAirSeriesManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/04/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class OnAirSeriesManager: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    var onAirSeries: [ResultSeriesOnAir]
    var navigationController: UINavigationController
    var viewModel: SeriesViewModel
    
    init(
        onAirSeries: [ResultSeriesOnAir],
        navigationController: UINavigationController,
        viewModel: SeriesViewModel
    ) {
        self.onAirSeries = onAirSeries
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onAirSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(OnTheAirCollectionViewCell.loadNib(), forCellWithReuseIdentifier: OnTheAirCollectionViewCell.identifier())
        let series = onAirSeries[indexPath.item]
        let cell: OnTheAirCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.prepareCell(with: series)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let series = onAirSeries[indexPath.item]
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.detailSeriesOnAir(onAirSeries: series)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (onAirSeries.count) - 10 {
            viewModel.seriesOnAirPage += 1
            viewModel.fetchSeriesOnAir()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150, height: 200)
    }
}
