//
//  CastCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 02/11/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castName: UILabel!
    
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
    
    
    
    func prepareCell(with serie: CastElement) {
        if let logoPath = serie.profilePath {
            guard let logoURL = URL(string: "https://image.tmdb.org/t/p/w92" + logoPath) else { return }
            let processor = DownsamplingImageProcessor(size: castImage.bounds.size)
            self.castImage.kf.setImage(
                with: logoURL,
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
            self.castImage.kf.indicatorType = .activity
            self.castImage.clipsToBounds = true
            self.castImage.layer.cornerRadius = castImage.frame.size.height / 2
            self.castName.text = serie.name
        }
    }
}
