//
//  NewDiscoverMoviesView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import JGProgressHUD
import SwiftUI

protocol DiscoverMoviesHomeViewControllerProtocol: AnyObject {
    func showMovies(_ movieList: [ResultDiscover])
}

final class DiscoverMoviesHomeViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MovieResult>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, MovieResult>
    
    weak var coordinator: MainCoordinator?

    enum Section {
        case main
    }
    
    private let hud = JGProgressHUD()
    private var dataSource: DataSource!
    private var snapshot: DataSourceSnapshot!
    private var favoriteMovies: MoviesDataModel?
    private var searching = false
    private var viewModel: DiscoverViewModel
    private var newDiscoverView = NewDiscoverMoviesView()
    
    init(viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newDiscoverView.topRatedCollection.delegate = self
        newDiscoverView.topRatedCollection.dataSource = dataSource
        viewModel.fetchMovies()
        viewModel.delegate = self
        viewModel.configureNavigate(controller: self)
        setupNavItens()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupNavItens() {
        let favoritesNavButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(goToFavorites))
        let searchNavButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(goToMoviesSearch))
        navigationItem.rightBarButtonItems = [favoritesNavButton, searchNavButton]
    }
    
    @objc
    private func goToFavorites() {
        let coordinator = MainCoordinator(navigationController: self.navigationController ?? UINavigationController())
        coordinator.favoritesMovies()
    }
    
    @objc
    private func goToMoviesSearch() {
        let coordinator = MainCoordinator(navigationController: self.navigationController ?? UINavigationController())
        coordinator.searchMovies()
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
    
    private func applySnapshot(result: [MovieResult]) {
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

extension DiscoverMoviesHomeViewController: CodeView {
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

extension DiscoverMoviesHomeViewController: DiscoverMoviesHomeViewControllerProtocol{
    func showMovies(_ movieList: [ResultDiscover]) {
        let section = DiscoverMoviesSection(movies: self.viewModel.discoverMovies )
        section.delegate = self
        newDiscoverView.discoverCollection.update(sections: [section])
    }
}

extension DiscoverMoviesHomeViewController: DiscoverMoviesSectionDelegate {
    func didTapCell(indexPath: IndexPath) {
        let movie = viewModel.discoverMovies[indexPath.item]
        let coordinator = MainCoordinator(navigationController: self.navigationController!)
        coordinator.detailDiscover(discoverMovies: movie)
    }
}

extension DiscoverMoviesHomeViewController: DiscoverViewModelDelegate {
    func successDiscoverList() {
        self.showSimpleHUD()
        DispatchQueue.main.async {
            self.showMovies(self.viewModel.discoverMovies)
            self.configureCollectionDataSource()
            self.hud.dismiss()
        }
    }
    
    func errorList() {
        present(ErrorViewController(), animated: true, completion: nil)
    }
}

extension DiscoverMoviesHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = dataSource.itemIdentifier(for: indexPath) else { return }
        let coordinator = MainCoordinator(navigationController: self.navigationController!)
        coordinator.detailDiscoverPop(discoverMovies: movie)
    }
}
