//
//  SeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController {

    var seriesPopular: [ResultSeries] = []
    var seriesTopRated: [ResultTopRated] = []
    var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    var total = 0
    var page = 0
    
    @IBOutlet weak var collectionViewPopular: UICollectionView!
    @IBOutlet weak var collectionViewTopRated: UICollectionView!
    
    override func viewDidLoad() {
        label.text = "Carregando Séries..."
        
        super.viewDidLoad()
        collectionViewPopular.dataSource = self
        collectionViewPopular.delegate = self
        
        collectionViewTopRated.dataSource = self
        collectionViewTopRated.delegate = self
        
//        collectionViewPopular.register(SeriesCollectionViewCell.self, forCellWithReuseIdentifier: "SeriesCollectionCell")
//        collectionViewTopRated.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: "TopRatedCollectionViewCell")
        
        RequestAPI.loadPopularSeries(onComplete: { (serie) in
            if let serie = serie {
                self.seriesPopular += serie.results
                self.total = serie.totalResults ?? 0
                self.page = serie.totalPages ?? 0
                print("Total: \(self.total)", "Inclusos: \(self.seriesPopular.count)" )
                DispatchQueue.main.async {
                    self.label.text = "Não existem filmes"
                    self.collectionViewPopular.reloadData()
                }
            }
        }) { (error) in
               print(error)
        }
        
        RequestAPI.loadTopRatedSeries(onComplete: { (serie) in
            if let serie = serie {
                self.seriesTopRated += serie.results
                self.total = serie.totalResults ?? 0
                self.page = serie.totalPages ?? 0
                print("Total: \(self.total)")
                DispatchQueue.main.async {
                    self.label.text = "Não existem filmes"
                    self.collectionViewPopular.reloadData()
                }
            }
        }) { (error) in
            print(error)
        }
        
    }
}

extension SeriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewPopular{
            return seriesPopular.count
        } else {
            return seriesTopRated.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionViewPopular {
            let cellSerie = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCollectionCell", for: indexPath) as! SeriesCollectionViewCell
            let serie = seriesPopular[indexPath.item]
            cellSerie.prepareCell(with: serie)
            return cellSerie
        } else {
            let cellTop = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionViewCell", for: indexPath) as! TopRatedCollectionViewCell
            let serie = seriesTopRated[indexPath.item]
            cellTop.prepareCell(with: serie)
            return cellTop
        }

        

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("toquei aqui")
        let serie = seriesPopular[indexPath.item]
        let detailSeries = DetailSeriesViewController(series: serie)
        self.navigationController?.present(detailSeries, animated: true, completion: nil)
    }
}
