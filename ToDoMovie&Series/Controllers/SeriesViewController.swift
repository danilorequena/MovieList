//
//  SeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController {
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
        label.text = "Carregando Séries..."
        setupCollectionView()
        mainViewModel = MainViewModel()
        mainViewModel?.delegate = self
        mainViewModel?.fetchPopularSeries()
//        mainViewModel?.fetchTopRatedSeries()
        mainViewModel?.fetchSeriesOnAir()
    }
}

extension SeriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupCollectionView() {
        collectionViewPopular.dataSource = self
        collectionViewPopular.delegate = self
        
        collectionViewOnAir.dataSource = self
        collectionViewOnAir.delegate = self
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
            let cellPopular = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.seriesPopular, for: indexPath) as! SeriesPopularCollectionViewCell
            let serie = mainViewModel?.seriesPopular[indexPath.item]
            cellPopular.prepareCell(with: serie!)
            return cellPopular
        } else {
            let cellOnAir = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.seriesTop, for: indexPath) as! OnAirCollectionViewCell
            let serie = mainViewModel?.seriesOnAir[indexPath.item]
            cellOnAir.prepareCell(with: serie!)
            return cellOnAir
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("toquei aqui")
        if collectionView == collectionViewPopular {
            let serie = mainViewModel?.seriesPopular[indexPath.item]
            let detailSeries = DetailSeriesViewController(series: serie!)
            self.navigationController?.present(detailSeries, animated: true, completion: nil)
        } else {
            let serie = mainViewModel?.seriesOnAir[indexPath.item]
            let detailSeries = SeriesOnAirViewController(series: serie!)
            self.navigationController?.present(detailSeries, animated: true, completion: nil)
        }
    }
}

extension SeriesViewController: MainViewModelDelegate {
    func successList() {
        DispatchQueue.main.async {
            self.collectionViewOnAir.reloadData()
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
