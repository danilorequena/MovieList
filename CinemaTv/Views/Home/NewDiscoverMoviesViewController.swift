//
//  NewDiscoverMoviesView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD

protocol MovieViewControllerProtocol: AnyObject {
    func showMovies(_ movieList: [ResultDiscover])
}

final class NewDiscoverMoviesViewController: UIViewController, UICollectionViewDelegate {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Result>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Result>
    
    enum Section {
        case main
    }
    
    private let hud = JGProgressHUD()
    private let layout = UICollectionViewFlowLayout()
    
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
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.numberOfLines = 1
        label.text = "Discover"
    
        return label
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
    
    private var topRatedCollection: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        return collectionView
    }()
    
    private var dataSource: DataSource!
    private var snapshot: DataSourceSnapshot!
    
    private var viewModel: DiscoverViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        viewModel = DiscoverViewModel()
        viewModel?.fetchMovies()
        viewModel?.delegate = self
        viewModel?.configureNavigate(controller: self)
        tabBarController?.tabBar.isHidden = false
        setupView()
    }
    
    private func showSimpleHUD() {
        DispatchQueue.main.async {
            self.hud.vibrancyEnabled = true
            self.hud.textLabel.text = "Loading..."
            self.hud.detailTextLabel.text = ""
            self.hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
            self.hud.show(in: self.view)
        }
    }
    
    private func configureCollection() {
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        topRatedCollection.delegate = self
        topRatedCollection.dataSource = dataSource
        topRatedCollection.register(TopRatedMovieCell.self, forCellWithReuseIdentifier: TopRatedMovieCell.identifier)
        topRatedCollection.collectionViewLayout = layout
    }
    
    private func configureCollectionDataSource() {
        dataSource = DataSource(
            collectionView: topRatedCollection,
            cellProvider: { (collectionView, indexPath, result) -> TopRatedMovieCell? in
                
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TopRatedMovieCell.identifier,
                for: indexPath) as! TopRatedMovieCell
                
            cell.setupCell(movie: result)
            return cell
        })
        applySnapshot(result: viewModel?.topRatedMovies ?? [])
    }
    
    private func applySnapshot(result: [Result]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(result)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension NewDiscoverMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(bgView)
        bgView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(discoverCollection)
        contentView.addSubview(topRatedCollection)
    }
    
    func setupConstraints() {
        bgView.bindFrameToSuperviewBounds()
        contentView.bindFrameToSuperviewSafeBounds()
        titleLabel.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
        discoverCollection.anchor(
            top: titleLabel.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 16, left: 8, bottom: 0, right: 8)
        )
        discoverCollection.anchor(height: UIScreen.main.bounds.height / 2)
        
        topRatedCollection.anchor(
            top: discoverCollection.bottomAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            insets: .init(top: 16, left: 8, bottom: 0, right: 8)
        )
        topRatedCollection.anchor(height: 180)
    }
    
    func setupAdditionalConfiguration() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
    }
}

extension NewDiscoverMoviesViewController: MovieViewControllerProtocol{
    func showMovies(_ movieList: [ResultDiscover]) {
            let section = DiscoverMoviesSection(movies: self.viewModel?.discoverMovies ?? [])
            self.discoverCollection.update(sections: [section])
    }
}

extension NewDiscoverMoviesViewController: DiscoverViewModelDelegate {
    func successDiscoverList() {
        showSimpleHUD()
        DispatchQueue.main.async {
            self.showMovies(self.viewModel?.discoverMovies ?? [])
            self.configureCollectionDataSource()
            self.hud.dismiss()
        }
    }
    
    func errorList() {
        DispatchQueue.main.async {
            self.showMovies(self.viewModel?.discoverMovies ?? [])
        }
    }
}
