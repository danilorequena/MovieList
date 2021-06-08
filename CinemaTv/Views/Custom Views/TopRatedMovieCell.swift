//
//  TopRatedMovieCell.swift
//  CinemaTv
//
//  Created by Danilo Requena on 16/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

final class TopRatedMovieCell: UICollectionViewCell {
    
    private var imgMovie: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func setupCell(movie: MovieResult) {
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: Constants.basePosters + posterPath)
            imgMovie.kf.setImage(with: posterURL)
            self.imgMovie.clipsToBounds = true
            self.imgMovie.layer.cornerRadius = 10
        }
    }
}

extension TopRatedMovieCell: CodeView {
    func buildViewHierarchy() {
        addSubview(imgMovie)
    }
    
    func setupConstraints() {
        imgMovie.bindFrameToSuperviewBounds()
        imgMovie.anchor(height: 200, width: 100)
    }
    
    
}
