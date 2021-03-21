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
import SwiftUI

protocol MovieViewControllerProtocol: AnyObject {
    func showMovies(_ movieList: [ResultDiscover])
}

final class NewDiscoverMoviesViewController: UIViewController, UICollectionViewDelegate {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Result>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Result>
    
    weak var coordinator: MainCoordinator?

    enum Section {
        case main
    }
    
    private let hud = JGProgressHUD()
    private var dataSource: DataSource!
    private var snapshot: DataSourceSnapshot!
    private var favoriteMovies: MoviesDataModel?
    
    private var viewModel =  DiscoverViewModel()
    private var newDiscoverView = NewDiscoverMoviesView()
    private var loading = ErrorViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        newDiscoverView.topRatedCollection.delegate = self
        newDiscoverView.topRatedCollection.dataSource = dataSource
        viewModel = DiscoverViewModel()
        viewModel.fetchMovies()
        viewModel.delegate = self
        viewModel.configureNavigate(controller: self)
        tabBarController?.tabBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(goToFavorites))
        setupView()
    }
    
    @objc func goToFavorites() {
        print("tapped")
        let coordinator = MainCoordinator(navigationController: self.navigationController ?? UINavigationController())
        coordinator.favoritesMovies()
    }

    private func configureCollectionDataSource() {
        dataSource = DataSource(
            collectionView: newDiscoverView.topRatedCollection,
            cellProvider: { (collectionView, indexPath, result) -> TopRatedMovieCell? in

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TopRatedMovieCell.identifier,
                for: indexPath) as! TopRatedMovieCell

            cell.setupCell(movie: result)
            return cell
        })
        applySnapshot(result: viewModel.topRatedMovies )
    }

    private func applySnapshot(result: [Result]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(result)
        dataSource.apply(snapshot, animatingDifferences: true)
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
    
    func saveSerieFavorite(indexPath: IndexPath) {
        let data = viewModel.discoverMovies[indexPath.item]
        favoriteMovies = MoviesDataModel(context: context)
        favoriteMovies?.movieName = data.title
        favoriteMovies?.movieImage = data.backdropPath
        favoriteMovies?.movieDescription = data.overview
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension NewDiscoverMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(newDiscoverView)
    }
    
    func setupConstraints() {
        newDiscoverView.bindFrameToSuperviewBounds()
    }
    
    func setupAdditionalConfiguration() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
    }
}

extension NewDiscoverMoviesViewController: MovieViewControllerProtocol{
    func showMovies(_ movieList: [ResultDiscover]) {
        let section = DiscoverMoviesSection(movies: self.viewModel.discoverMovies )
        section.delegate = self
        newDiscoverView.discoverCollection.update(sections: [section])
    }
}

extension NewDiscoverMoviesViewController: DiscoverMoviesSectionDelegate {
    func didTapCell(indexPath: IndexPath) {
        let movie = viewModel.discoverMovies[indexPath.item]
        let coordinator = MainCoordinator(navigationController: self.navigationController!)
        coordinator.detailDiscover(discoverMovies: movie)
//        saveSerieFavorite(indexPath: indexPath)
//        let alert = UIAlertController(title: "atenção", message: "Filme gravado nos favoritos", preferredStyle: .alert)
//        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
        
    }
}

extension NewDiscoverMoviesViewController: DiscoverViewModelDelegate {
    func successDiscoverList() {
        self.showSimpleHUD()
        DispatchQueue.main.async {
            self.showMovies(self.viewModel.discoverMovies )
            self.configureCollectionDataSource()
            self.hud.dismiss()
        }
    }
    
    func errorList() {
        present(ErrorViewController(), animated: true, completion: nil)
    }
}
