//
//  MovieTableViewCell.swift
//  CinemaTv
//
//  Created by Danilo Requena on 16/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    var textTitleLabel: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var textDescriptionLabel: String? {
        get { descriptionLabel.text }
        set { descriptionLabel.text = newValue }
    }
    
    var textVotesLabel: String? {
        get { voteLabel.text }
        set { voteLabel.text = newValue }
    }
    
    private let bgView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 25
        view.layer.shadowOpacity = 1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private var imageMovie: UIImageView = {
        let image = UIImageView.Factory.build(
            backgroundColor: .lightGray,
            tintColor: .systemGray4,
            accessibilityIdentifier: ""
        )
        return image
    }()
    
    private let titleLabel = UILabel.Factory.build(
        textAlignment: .left,
        textStyle: .largeTitle,
        numberOfLines: 0,
        accessibilityIdentifier: "",
        textColor: .black,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 11
    )
    
    private let descriptionLabel = UILabel.Factory.build(
        textAlignment: .left,
        textStyle: .body,
        numberOfLines: 0,
        accessibilityIdentifier: "",
        textColor: .black,
        adjustsFontSizeToFitWidth: true,
        minimumScaleFactor: 11
    )
    
    private let voteLabel = UILabel.Factory.build(
        textAlignment: .left,
        textStyle: .subheadline,
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
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieTableViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(bgView)
        bgView.addSubview(imageMovie)
        bgView.addSubview(titleLabel)
        bgView.addSubview(descriptionLabel)
        bgView.addSubview(voteLabel)
    }
    
    func setupConstraints() {
        bgView.bindFrameToSuperviewBounds()
        imageMovie.anchor(
            top: bgView.topAnchor,
            leading: bgView.leadingAnchor,
            bottom: bgView.bottomAnchor,
            insets: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        titleLabel.anchor(
            top: bgView.topAnchor,
            leading: imageMovie.trailingAnchor,
            trailing: bgView.trailingAnchor,
            insets: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
        
        descriptionLabel.anchor(
            top: titleLabel.topAnchor,
            leading: imageMovie.trailingAnchor,
            trailing: bgView.trailingAnchor,
            insets: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
        
        voteLabel.anchor(
            top: descriptionLabel.topAnchor,
            leading: imageMovie.trailingAnchor,
            bottom: bgView.bottomAnchor,
            trailing: bgView.trailingAnchor,
            insets: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
    }
    
    
}
