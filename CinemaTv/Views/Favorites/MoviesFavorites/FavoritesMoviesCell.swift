//
//  FavoritesMoviesCell.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

protocol FavoritesDelegate: AnyObject {
    func didTapCell(model: MoviesDataModel)
}

final class FavoritesMoviesCell: UITableViewCell {
    
    weak var delegate: FavoritesDelegate?
    
    var model: MoviesDataModel? {
        didSet {
            if let model = model {
                imageFavorite.download(from: Constants.basePosters + model.movieImage!, placeHolder: UIImage(named: "noImage"))
                labelName.text = model.movieName
                labelDescription.text = model.movieDescription
                labelVotes.text = model.movieVotes
            }
        }
    }
    
    class func loadNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    private let imageFavorite: UIImageView = {
       let image = UIImageView()
        image.sizeToFit()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private let labelName = UILabel.Factory.build(
        textAlignment: .center,
        textStyle: .largeTitle,
        numberOfLines: 0,
        accessibilityIdentifier: "",
        textColor: .black,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 9
    )
    
    private let labelDescription = UILabel.Factory.build(
        textAlignment: .left,
        numberOfLines: 4,
        accessibilityIdentifier: "",
        textColor: .gray
    )
    
    private let labelVotes = UILabel.Factory.build(
        textAlignment: .left,
        textStyle: .largeTitle,
        numberOfLines: 1,
        accessibilityIdentifier: "",
        textColor: .black,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 9
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritesMoviesCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubviews(
            imageFavorite,
            labelName,
            labelDescription,
            labelVotes
        )
    }
    
    func setupConstraints() {
        contentView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            insets: .init(top: 8, left: 8, bottom: 8, right: 8)
        )
        imageFavorite.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            insets: .init(top: 8, left: 8, bottom: 0, right: 0)
        )
        imageFavorite.anchor(height: 120, width: 110)
        
        labelVotes.anchor(
            top: imageFavorite.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            insets: .init(top: 8, left: 0, bottom: 0, right: 8)
        )
        
        labelName.anchor(
            top: contentView.topAnchor,
            leading: imageFavorite.trailingAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
        
        labelDescription.anchor(
            top: labelName.bottomAnchor,
            leading: imageFavorite.trailingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 4, left: 8, bottom: 2, right: 8)
        )
    }
    
    func setupAdditionalConfiguration() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 5
        selectionStyle = .none
        
//        contentView.dropShadow(
//            offset: CGSize.init(width: 0, height: 3),
//            radius: 10,
//            opacity: 0.2,
//            color: UIColor.black.cgColor
//        )
//        contentView.shadowDefault()
    }
    
    
}
