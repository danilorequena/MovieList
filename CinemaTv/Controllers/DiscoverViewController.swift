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
    let flowLayout = ZoomAndSnapFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        tabBarController?.tabBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "about", style: .plain, target: self, action: #selector(showAboutMe))
        setupCollection()
        viewModel = DiscoverViewModel()
        viewModel?.delegate = self
        viewModel?.configureNavigate(controller: self)
        viewModel?.fetchDiscoverMovies()
    }
    
    @objc func showAboutMe() {
        print("tapped")
        let vc = AboutViewController()
        navigationController?.present(vc, animated: true, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == discovercollectView {
            if indexPath.item == (viewModel?.movies.count ?? 0) - 10 {
                viewModel?.page += 1
                viewModel?.fetchDiscoverMovies()
            }
        }
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
