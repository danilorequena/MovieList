//
//  NewDiscoverMoviesView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

protocol MovieViewControllerProtocol: AnyObject {
    func showMovies(_ movieList: [ResultDiscover])
}

final class NewDiscoverMoviesView: UIViewController {
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var discoverCollection: CinemaTvCollectionView = {
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
    
    private var viewModel: DiscoverViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DiscoverViewModel()
        viewModel?.fetchDiscoverMovies()
        viewModel?.delegate = self
        viewModel?.configureNavigate(controller: self)
        setupView()
    }
}

extension NewDiscoverMoviesView: CodeView {
    func buildViewHierarchy() {
        view.addSubview(bgView)
        bgView.addSubview(contentView)
        contentView.addSubview(discoverCollection)
    }
    
    func setupConstraints() {
        bgView.bindFrameToSuperviewBounds()
        contentView.bindFrameToSuperviewSafeBounds()
        discoverCollection.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 22, left: 8, bottom: 0, right: 8)
        )
        discoverCollection.anchor(height: UIScreen.main.bounds.height / 2)
    }
    
    func setupAdditionalConfiguration() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
    }
}

extension NewDiscoverMoviesView: MovieViewControllerProtocol{
    func showMovies(_ movieList: [ResultDiscover]) {
            let section = DiscoverMoviesSection(movies: self.viewModel?.movies ?? [])
            self.discoverCollection.update(sections: [section])
    }
}

extension NewDiscoverMoviesView: DiscoverViewModelDelegate {
    func successDiscoverList() {
        DispatchQueue.main.async {
            self.showMovies(self.viewModel?.movies ?? [])
        }
    }
    
    func errorList() {
        DispatchQueue.main.async {
            self.showMovies(self.viewModel?.movies ?? [])
        }
    }
}
