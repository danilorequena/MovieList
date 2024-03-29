//
//  WereWatchCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 23/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

class ProvidersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var wereWatchImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadowDefault()
    }
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    
    
    func prepareCell(with serie: ProvidersData) {
        if let logoPath = serie.logoPath {
            guard let logoURL = URL(string: "https://image.tmdb.org/t/p/w92" + logoPath) else { return }
            let processor = DownsamplingImageProcessor(size: .init(width: 48, height: 48))
            self.wereWatchImage.kf.setImage(
                with: logoURL,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.3)),
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
            self.wereWatchImage.kf.indicatorType = .activity
            self.wereWatchImage.clipsToBounds = true
            self.wereWatchImage.layer.cornerRadius = wereWatchImage.frame.size.height / 2
        }
    }

}
