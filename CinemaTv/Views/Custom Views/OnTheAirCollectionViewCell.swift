//
//  OnTheAirCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 12/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class OnTheAirCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageOnTheAir: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.shadowDefault()
    }
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func prepareCell(with serie: ResultSeriesOnAir) {
        if let posterPath = serie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w200" + posterPath)
            guard let data = try? Data(contentsOf: posterURL!) else { return }
            self.imageOnTheAir.image = UIImage(data: data)
            self.imageOnTheAir.clipsToBounds = true
            self.imageOnTheAir.layer.cornerRadius = 10
        }
    }


}
