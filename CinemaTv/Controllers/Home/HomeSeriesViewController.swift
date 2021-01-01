//
//  SeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class HomeSeriesViewController: UIViewController, Storyboaded {
    var mainViewModel: MainViewModel?
    var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    @IBOutlet weak var discoverSeriesCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewPopular: UICollectionView!
    @IBOutlet weak var collectionViewOnAir: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "TV Shows", preferredLargeTitle: true)
        label.text = "Carregando Séries..."
        setupCollectionView()
        mainViewModel = MainViewModel()
        mainViewModel?.delegate = self
        mainViewModel?.fetchPopularSeries()
        mainViewModel?.fetchSeriesOnAir()
        mainViewModel?.fetchDiscoverSeries()
    }
}

extension HomeSeriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupCollectionView() {
        collectionViewPopular.dataSource = self
        collectionViewPopular.delegate = self
        collectionViewPopular.register(PopularCollectionViewCell.loadNib(), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier())
        (collectionViewPopular.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 150, height: 200)
        collectionViewPopular.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
        
        collectionViewOnAir.dataSource = self
        collectionViewOnAir.delegate = self
        collectionViewOnAir.register(OnTheAirCollectionViewCell.loadNib(), forCellWithReuseIdentifier: OnTheAirCollectionViewCell.identifier())
        (collectionViewOnAir.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 150, height: 200)
        collectionViewOnAir.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
        
        discoverSeriesCollectionView.delegate = self
        discoverSeriesCollectionView.dataSource = self
        discoverSeriesCollectionView.register(DiscoverSeriesCollectionViewCell.loadNib(), forCellWithReuseIdentifier: DiscoverSeriesCollectionViewCell.identifier())
        (discoverSeriesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 182, height: 261)
        discoverSeriesCollectionView.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewPopular{
            return mainViewModel?.seriesPopular.count ?? 0
        } else if collectionView == collectionViewOnAir {
            return mainViewModel?.seriesOnAir.count ?? 0
        } else {
            return mainViewModel?.discoverSeries.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewPopular {
            let cellPopular = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier(), for: indexPath) as! PopularCollectionViewCell
            let serie = mainViewModel?.seriesPopular[indexPath.item]
            cellPopular.prepareCell(with: serie!)
            return cellPopular
        } else if collectionView == collectionViewOnAir {
            let cellOnAir = collectionView.dequeueReusableCell(withReuseIdentifier: OnTheAirCollectionViewCell.identifier(), for: indexPath) as! OnTheAirCollectionViewCell
            let serieOnAir = mainViewModel?.seriesOnAir[indexPath.item]
            cellOnAir.prepareCell(with: serieOnAir!)
            return cellOnAir
        } else {
            let discoverCell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverSeriesCollectionViewCell.identifier(), for: indexPath) as! DiscoverSeriesCollectionViewCell
            let discoverSeries = mainViewModel?.discoverSeries[indexPath.item]
            discoverCell.setupCell(tvShow: discoverSeries!)
            return discoverCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("toquei aqui")
        if collectionView == collectionViewPopular {
            guard let serie = mainViewModel?.seriesPopular[indexPath.item] else { return }
            let coordinator = MainCoordinator(navigationController: self.navigationController!)
            coordinator.detailSeries(popSeries: serie)
        } else if collectionView == collectionViewOnAir {
            guard let serie = mainViewModel?.seriesOnAir[indexPath.item] else { return }
            let coordinator = MainCoordinator(navigationController: self.navigationController!)
            coordinator.detailSeriesOnAir(onAirSeries: serie)
        } else {
            guard let serie = mainViewModel?.discoverSeries[indexPath.item] else { return }
            let coordinator = MainCoordinator(navigationController: self.navigationController!)
            coordinator.detailDiscoverSeries(discoverSeries: serie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == collectionViewPopular {
            if indexPath.item == (mainViewModel?.seriesPopular.count ?? 0) - 10 {
                mainViewModel?.popularPage += 1
                mainViewModel?.fetchPopularSeries()
            }
        } else {
            if indexPath.item == (mainViewModel?.seriesOnAir.count ?? 0) - 10 {
                mainViewModel?.seriesOnAirPage += 1
                mainViewModel?.fetchSeriesOnAir()
            }
        }
    }
}

extension HomeSeriesViewController: MainViewModelDelegate {
    func successDiscoverSeries() {
        DispatchQueue.main.async {
            self.discoverSeriesCollectionView.reloadData()
        }
    }
    
    func successListOnAir() {
        DispatchQueue.main.async {
            self.collectionViewOnAir.reloadData()
        }
    }
    
    func successListPopular() {
        DispatchQueue.main.async {
            self.collectionViewPopular.reloadData()
        }
    }
    func errorList() {
        DispatchQueue.main.async {
            self.label.text = "Não existem filmes"
            self.collectionViewOnAir.reloadData()
            self.collectionViewPopular.reloadData()
        }
    }
}
