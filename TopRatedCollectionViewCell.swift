//
//  TopRatedCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 05/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class TopRatedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivTopSeries: UIImageView!
       
    func prepareCell(with serie: ResultTopRated) {
        if let posterPath = serie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/" + posterPath)
            let data = try? Data(contentsOf: posterURL!)
            self.ivTopSeries.image = UIImage(data: data!)
        }
    }
}
