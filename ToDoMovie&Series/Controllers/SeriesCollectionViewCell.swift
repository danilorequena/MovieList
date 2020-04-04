//
//  SeriesCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 02/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var ivSeries: UIImageView!
    
    func prepareCell(with serie: ResultSeries) {
        if let posterPath = serie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w200/" + posterPath)
            let data = try? Data(contentsOf: posterURL!)
            self.ivSeries.image = UIImage(data: data!)
        }
    }
}
