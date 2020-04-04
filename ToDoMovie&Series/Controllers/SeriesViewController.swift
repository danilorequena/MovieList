//
//  SeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController {

    var series: [ResultSeries] = []
    var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    var total = 0
    var page = 0
    @IBOutlet weak var collectionViewPopular: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewPopular.dataSource = self
        collectionViewPopular.delegate = self
        
        RequestAPI.loadSeries(onComplete: { (serie) in
            if let serie = serie {
                self.series += serie.results
                self.total = serie.totalResults ?? 0
                self.page = serie.totalPages ?? 0
                print("Total: \(self.total)", "Inclusos: \(self.series.count)" )
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
        return series.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesCollectionCell", for: indexPath) as! SeriesCollectionViewCell
        
        let serie = series[indexPath.item]
        cell.prepareCell(with: serie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("toquei aqui")
        let serie = series[indexPath.item]
        let detailSeries = DetailSeriesViewController(series: serie)
        self.navigationController?.present(detailSeries, animated: true, completion: nil)
    }
}
