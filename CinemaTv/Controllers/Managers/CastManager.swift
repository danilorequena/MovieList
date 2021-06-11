//
//  OverlayManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 22/04/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class CastManager: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    private var viewModel: OverlayViewModel
    
    init(viewModel: OverlayViewModel) {
        self.viewModel = viewModel
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(CastCollectionViewCell.loadNib(), forCellWithReuseIdentifier: CastCollectionViewCell.identifier())
        let cell: CastCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let cast = viewModel.cast[indexPath.item]
        cell.prepareCell(with: cast)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel.details?.homepage ?? "https://apple.com") else { return }

        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
