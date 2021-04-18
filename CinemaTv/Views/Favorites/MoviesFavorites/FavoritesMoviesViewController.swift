//
//  MoviesFavoritesViewController.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import CoreData

protocol FavoriteViewProtocol: AnyObject {
    func update(items: [String])
}

final class FavoritesMoviesViewController: UIViewController {
    typealias FavoriteDataSource = UITableViewDiffableDataSource<Section, Result>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Result>
    
    enum Section {
        case main
    }
    
    var fetchedResultsController: NSFetchedResultsController<MoviesDataModel>!
    var moviesData: [MoviesDataModel]?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(FavoritesMoviesCell.self)
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadFavorites()
        moviesData = [MoviesDataModel]()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func loadFavorites() {
        let fetchRequest: NSFetchRequest<MoviesDataModel> = MoviesDataModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "movieName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
        try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
}



extension FavoritesMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.bindFrameToSuperviewBounds()
    }
    
    func setupAdditionalConfiguration() {
        configureNavigationBar(
            largeTitleColor: .white,
            backgoundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
            tintColor: .white,
            title: "Favorites",
            preferredLargeTitle: true
        )
    }
}

extension FavoritesMoviesViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                break
            default:
                tableView.reloadData()
        }
    }
}

extension FavoritesMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesMoviesCell.identifier, for: indexPath) as! FavoritesMoviesCell
        guard let model = fetchedResultsController.fetchedObjects?[indexPath.section] else {
            return cell
        }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { (action, view, actionPerformed: (Bool) -> ()) in
            guard let favorite = self.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
            self.context.delete(favorite)
            actionPerformed(true)
        }
        delete.image = UIImage(systemName: "trash")
        let config = UISwipeActionsConfiguration(actions: [delete])
        return config
    }
}
