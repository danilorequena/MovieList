//
//  MoviesSearchViewController.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/06/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol MoviesSearchViewControllerProtocol: AnyObject {
    func showMovies(_ movieList: [ResultDiscover])
    func hideMovies()
}

final class MoviesSearchViewController: UIViewController, MoviesSearchManagerDelegate {
    func didTapMovie(indexPath: IndexPath) {
        
    }
    weak var coordinator: MainCoordinator?
    
    private var searching = false
    private let hud = JGProgressHUD()
    private let viewModel: MoviesSearchViewModel
    
    private(set) lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.delegate = self
        controller.searchBar.delegate = self
        controller.searchBar.placeholder = "Busca"
        controller.searchBar.accessibilityIdentifier = "searchController"
        controller.obscuresBackgroundDuringPresentation = false
        controller.hidesBottomBarWhenPushed = true
        controller.hidesNavigationBarDuringPresentation = true
        return controller
    }()
    
    private lazy var collectionMoviesSearch: CinemaTvCollectionView = {
        let collectionView = CinemaTvCollectionView(
            sections: [],
            contentInset: .init(inset: 8),
            flowLayout: UICollectionViewFlowLayout(),
            minimumCellSpacing: 8,
            minimumInterItemSpacing: 8
        )
        collectionView.setBackground(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let emptyView = EmptyStateView()
    
    init(viewModel: MoviesSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.delegate = self
        viewModel.fetchSearch(movie: "")
        setupSearch()
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        title = "Search"
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
}

extension MoviesSearchViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubviews(collectionMoviesSearch, emptyView)
    }
    
    func setupConstraints() {
        collectionMoviesSearch.bindFrameToSuperviewBounds()
        emptyView.bindFrameToSuperviewBounds()
    }
    
    func setupAdditionalConfiguration() {
        collectionMoviesSearch.backgroundColor = .white
    }
}

extension MoviesSearchViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchSearch(movie: "Jobs")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchSearch(movie: searchText)
    }
}

extension MoviesSearchViewController: MoviesSearchViewModelDelegate {
    func successSearch() {
        showSimpleHUD()
        DispatchQueue.main.async {
            if !self.viewModel.movies.isEmpty {
                self.showMovies(self.viewModel.movies)
                self.hud.dismiss()
            } else {
                self.hideMovies()
            }
        }
    }
    
    func errorSearch() {
        print("deu erro")
    }
}

extension MoviesSearchViewController: MoviesSearchViewControllerProtocol {
    func showMovies(_ movieList: [ResultDiscover]) {
        collectionMoviesSearch.isHidden = false
        emptyView.isHidden = true
        let section = MoviesSearchSection(movies: movieList)
        section.delegate = self
        collectionMoviesSearch.update(sections: [section])
    }
    
    func hideMovies() {
        collectionMoviesSearch.isHidden = true
        emptyView.isHidden = false
    }
}
