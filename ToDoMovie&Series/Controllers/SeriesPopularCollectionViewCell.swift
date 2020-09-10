//
//  SeriesCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 02/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class SeriesPopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivSeriesPopular: UIImageView!
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func prepareCell(with serie: ResultSeries) {
        if let posterPath = serie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w200" + posterPath)
            let data = try? Data(contentsOf: posterURL!)
            self.ivSeriesPopular.image = UIImage(data: data!)
            self.ivSeriesPopular.clipsToBounds = true
            self.ivSeriesPopular.layer.cornerRadius = 10
        }
        self.shadowDefault()
    }
}
