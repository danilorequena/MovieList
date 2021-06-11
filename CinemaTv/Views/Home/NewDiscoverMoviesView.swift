//
//  NewDiscoverMoviesView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 17/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class NewDiscoverMoviesView: UIView {
    let layout = UICollectionViewFlowLayout()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let discoverTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.numberOfLines = 1
        label.text = "Discover"
    
        return label
    }()
    
     lazy var discoverCollection: CinemaTvCollectionView = {
       let collectionView = CinemaTvCollectionView(
        sections: [],
        flowLayout: UICollectionViewFlowLayout(),
        minimumCellSpacing: 16,
        minimumInterItemSpacing: 16
       )
        collectionView.setBackground(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.flowLayout.scrollDirection = .horizontal
        collectionView.flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return collectionView
    }()
    
     let topRatedTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.numberOfLines = 1
        label.text = "Top Rated"
    
        return label
    }()
    
     var topRatedCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureCollection()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollection() {
        layout.scrollDirection = .horizontal
        layout.itemSize.height = 180
        layout.itemSize.width = 120
        topRatedCollection.register(TopRatedMovieCell.self, forCellWithReuseIdentifier: TopRatedMovieCell.identifier)
        topRatedCollection.collectionViewLayout = layout
    }
}

extension NewDiscoverMoviesView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            discoverTitleLabel,
            discoverCollection,
            topRatedTitleLabel,
            topRatedCollection
        )
    }
    
    func setupConstraints() {
        scrollView.bindFrameToSuperviewBounds()
        contentView.bindFrameToSuperviewBounds()
        contentView.anchor(width: UIScreen.main.bounds.width)
        discoverTitleLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
        discoverCollection.anchor(
            top: discoverTitleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 16, left: 8, bottom: 0, right: 8)
        )
        discoverCollection.anchor(height: UIScreen.main.bounds.height / 2)
        
        topRatedTitleLabel.anchor(
            top: discoverCollection.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 22, left: 8, bottom: 0, right: 8)
        )
        
        topRatedCollection.anchor(
            top: topRatedTitleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 16, left: 8, bottom: 16, right: 8)
        )
        topRatedCollection.anchor(height: 200)
    }
}
