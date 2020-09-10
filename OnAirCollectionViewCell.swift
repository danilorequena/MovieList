//
//  TopRatedCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 05/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class OnAirCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivTopSeries: UIImageView!
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
       
    func prepareCell(with serie: ResultSeriesOnAir) {
        if let posterPath = serie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w200" + posterPath)
            let data = try? Data(contentsOf: posterURL!)
            self.ivTopSeries.image = UIImage(data: data!)
            self.ivTopSeries.clipsToBounds = true
            self.ivTopSeries.layer.cornerRadius = 10
        }
        self.shadowDefault()
    }
}
