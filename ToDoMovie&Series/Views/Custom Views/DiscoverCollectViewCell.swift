//
//  DiscoverCollectViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverCollectViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgDiscoverMovie: UIImageView!
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
    
    func transformToLarge() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.50, y: 1.50)
        }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    func transformToStandard() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform.identity
        }
    }
    
    func setupCell(movie: ResultDiscover) {
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/original" + posterPath)
//            guard let data = try? Data(contentsOf: posterURL!) else { return }
//            self.popularImage.image = UIImage(data: data)
            let processor = DownsamplingImageProcessor(size: imgDiscoverMovie.bounds.size)
            self.imgDiscoverMovie.kf.setImage(
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
            self.imgDiscoverMovie.clipsToBounds = true
            self.imgDiscoverMovie.layer.cornerRadius = 10
        }
    }
    
}
