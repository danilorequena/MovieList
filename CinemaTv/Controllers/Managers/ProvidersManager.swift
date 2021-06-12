//
//  WereWatchManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 22/04/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class ProvidersManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    private var viewModel: OverlayViewModel
    
    init(viewModel: OverlayViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.providers?.flatrate?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(ProvidersCollectionViewCell.loadNib(), forCellWithReuseIdentifier: ProvidersCollectionViewCell.identifier())
        let cell: ProvidersCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let cast = viewModel.providers?.flatrate?[indexPath.item]
        cell.prepareCell(with: cast!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel.providers?.link ?? "") else { return }

        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 48, height: 48)
    }
    
    
}

