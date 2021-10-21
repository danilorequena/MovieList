//
//  MoviesSearchCell.swift
//  CinemaTv
//
//  Created by Danilo Requena on 19/07/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

final class MoviesSearchCell: UICollectionViewCell {
    private var image = UIImageView.Factory.build(
        contentMode: .scaleAspectFit,
        backgroundColor: .darkGray,
        tintColor: .black,
        accessibilityIdentifier: "imageSearch"
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    func prepareCell(with movie: ResultDiscover) {
        if let movie = movie.posterPath {
            image.download(
                from: URL(string: Constants.basePosters + movie),
                placeHolder: .init(named: "placeholder")
            )
        }
    }
}

extension MoviesSearchCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(image)
    }
    
    func setupConstraints() {
        image.bindFrameToSuperviewBounds()
    }
}
