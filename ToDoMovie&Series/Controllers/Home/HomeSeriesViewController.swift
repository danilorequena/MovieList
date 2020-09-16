//
//  SeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class HomeSeriesViewController: UIViewController {
    var mainViewModel: MainViewModel?
    var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
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
    }
}

extension HomeSeriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupCollectionView() {
        collectionViewPopular.dataSource = self
        collectionViewPopular.delegate = self
        collectionViewPopular.register(PopularCollectionViewCell.loadNib(), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier())
        (collectionViewPopular.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 150, height: 170)
        collectionViewPopular.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
        
        collectionViewOnAir.dataSource = self
        collectionViewOnAir.delegate = self
        collectionViewOnAir.register(OnTheAirCollectionViewCell.loadNib(), forCellWithReuseIdentifier: OnTheAirCollectionViewCell.identifier())
        (collectionViewOnAir.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 150, height: 170)
        collectionViewOnAir.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewPopular{
            return mainViewModel?.seriesPopular.count ?? 0
        } else {
            return mainViewModel?.seriesOnAir.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewPopular {
            let cellPopular = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier(), for: indexPath) as! PopularCollectionViewCell
            let serie = mainViewModel?.seriesPopular[indexPath.item]
            cellPopular.prepareCell(with: serie!)
            return cellPopular
        } else {
            let cellOnAir = collectionView.dequeueReusableCell(withReuseIdentifier: OnTheAirCollectionViewCell.identifier(), for: indexPath) as! OnTheAirCollectionViewCell
            let serieOnAir = mainViewModel?.seriesOnAir[indexPath.item]
            cellOnAir.prepareCell(with: serieOnAir!)
            return cellOnAir
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("toquei aqui")
        if collectionView == collectionViewPopular {
            let serie = mainViewModel?.seriesPopular[indexPath.item]
            let detailSeries = DetailPopSeriesViewController(series: serie!)
            self.navigationController?.pushViewController(detailSeries, animated: true)
        } else {
            let serie = mainViewModel?.seriesOnAir[indexPath.item]
            let detailSeries = DetailSeriesOnAirViewController(series: serie!)
            self.navigationController?.pushViewController(detailSeries, animated: true)
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
