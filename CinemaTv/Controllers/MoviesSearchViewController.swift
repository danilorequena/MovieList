//
//  MoviesSearchViewController.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/06/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import JGProgressHUD

final class MoviesSearchViewController: UIViewController {
    private var searching = false
    private let hud = JGProgressHUD()
    
    private(set) lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.delegate = self
        controller.searchBar.delegate = self
        controller.searchBar.placeholder = "Busca"
        controller.searchBar.accessibilityIdentifier = "searchController"
        controller.obscuresBackgroundDuringPresentation = true
        controller.hidesBottomBarWhenPushed = true
        controller.hidesNavigationBarDuringPresentation = true
        return controller
    }()
    
    private let collectionMoviesSearch: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.delegate = self
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
        view.addSubview(collectionMoviesSearch)
    }
    
    func setupConstraints() {
        collectionMoviesSearch.bindFrameToSuperviewSafeBounds()
    }
}

extension MoviesSearchViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
//        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchGists = gistsData.filter({$0.owner.ownerName.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
//        tableView.reloadData()
    }
}

extension MoviesSearchViewController: MoviesSearchViewModelDelegate {
    func successSearch() {
        showSimpleHUD()
        DispatchQueue.main.async {
        //TODO: - IMPLEMENTAR O CODIGO AQUI
            self.hud.dismiss()
        }
    }
    
    func errorSearch() {
        print("deu erro")
    }
}
