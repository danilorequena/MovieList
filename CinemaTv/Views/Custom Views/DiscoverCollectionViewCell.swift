//
//  DiscoverCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgDiscover: UIImageView!
    
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
    
    func setupCell(movie: ResultDiscover) {
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
            let processor = DownsamplingImageProcessor(size: imgDiscover.bounds.size)
            self.imgDiscover.kf.setImage(
                with: posterURL,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.5)),
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
            self.imgDiscover.clipsToBounds = true
            self.imgDiscover.layer.cornerRadius = 10
        }
    }

}
