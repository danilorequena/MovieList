//
//  DiscoverSeriesCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 10/11/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverSeriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageDisSeries: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shadowDefault()
    }
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func setupCell(movie: ResultDiscoverSeries) {
        //TODO: - Mudar o modelo acima
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
            let processor = DownsamplingImageProcessor(size: imageDisSeries.bounds.size)
            self.imageDisSeries.kf.setImage(
                with: posterURL,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ], completionHandler:
                    {
                        result in
                        switch result {
                        case .success(let value):
                            print("Task done for: \(value.source.url?.absoluteString ?? "")")
                        case .failure(let error):
                            print("Job failed: \(error.localizedDescription)")
                        }
                    })
            self.imageDisSeries.clipsToBounds = true
            self.imageDisSeries.layer.cornerRadius = 10
        }
    }

}
