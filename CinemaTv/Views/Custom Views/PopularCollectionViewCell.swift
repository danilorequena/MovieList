//
//  PopularCollectionViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 12/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var popularImage: UIImageView!
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
    
    func prepareCell(with serie: ResultSeries) {
        if let posterPath = serie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w200" + posterPath)
//            guard let data = try? Data(contentsOf: posterURL!) else { return }
//            self.popularImage.image = UIImage(data: data)
            let processor = DownsamplingImageProcessor(size: popularImage.bounds.size)
            self.popularImage.kf.setImage(
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
            self.popularImage.clipsToBounds = true
            self.popularImage.layer.cornerRadius = 10
        }
    }

}
