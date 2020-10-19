//
//  DiscoverMoviesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class DiscoverMoviesViewController: UIViewController {

    @IBOutlet weak var discover: UICollectionView!
    
    var viewModel: DiscoverViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        viewModel = DiscoverViewModel()
        viewModel?.delegate = self
        viewModel?.fetchDiscoverMovies()
    }

}

extension DiscoverMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollection() {
        self.discover.register(DiscoverCollectionViewCell.loadNib(), forCellWithReuseIdentifier: DiscoverCollectionViewCell.identifier())
        self.discover.delegate = self
        self.discover.dataSource  = self
        (self.discover.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverCollectionViewCell.identifier(), for: indexPath) as! DiscoverCollectionViewCell
        let movies = viewModel?.movies[indexPath.item]
        cell.setupCell(movie: movies!)
        return cell
    }
}

extension DiscoverMoviesViewController: DiscoverViewModelDelegate {
    func successDiscoverList() {
        DispatchQueue.main.async {
            self.discover.reloadData()
        }
    }
    
    func errorList() {
        DispatchQueue.main.async {
            self.discover.reloadData()
        }
    }
    
    
}

