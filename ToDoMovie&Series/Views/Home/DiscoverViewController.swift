//
//  DiscoverViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 26/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, Storyboaded {

    @IBOutlet weak var discovercollectView: UICollectionView!
    
    weak var coordinator: MainCoordinator?
    
    var viewModel: DiscoverViewModel?
    var centerCell: DiscoverCollectViewCell?
    let flowLayout = ZoomAndSnapFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "Discover", preferredLargeTitle: true)
        setupCollection()
        viewModel = DiscoverViewModel()
        viewModel?.delegate = self
        viewModel?.fetchDiscoverMovies()
    }

}

extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupCollection() {
        self.discovercollectView.register(DiscoverCollectionViewCell.loadNib(), forCellWithReuseIdentifier: DiscoverCollectionViewCell.identifier())
        self.discovercollectView.delegate = self
        self.discovercollectView.dataSource  = self
        self.discovercollectView.collectionViewLayout = flowLayout
        self.discovercollectView.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
        self.discovercollectView.showsHorizontalScrollIndicator = false
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = viewModel?.movies[indexPath.item] else { return }
        let coordinator = MainCoordinator(navigationController: self.navigationController!)
        coordinator.detailDiscover(discoverMovies: movie)
    }
}

extension DiscoverViewController: DiscoverViewModelDelegate {
    func successDiscoverList() {
        DispatchQueue.main.async {
            self.discovercollectView.reloadData()
        }
    }
    
    func errorList() {
        DispatchQueue.main.async {
            self.discovercollectView.reloadData()
        }
    }
}
