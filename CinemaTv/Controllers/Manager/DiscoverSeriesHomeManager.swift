//
//  DiscoverSeriesHomeManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 18/04/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class DiscoverSeriesHomeManager: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var discoverSeries: [ResultDiscoverSeries]
    
    init(discoverSeries: [ResultDiscoverSeries]) {
        self.discoverSeries = discoverSeries
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        discoverSeries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let series = discoverSeries[indexPath.item]
        let cell: DiscoverSeriesCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setupCell(tvShow: series)
        return cell
    }
}
