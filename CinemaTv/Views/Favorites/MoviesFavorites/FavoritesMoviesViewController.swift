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
    typealias FavoriteDataSource = UITableViewDiffableDataSource<Section, MovieResult>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, MovieResult>
    
    enum Section {
        case main
    }
    
    var fetchedResultsController: NSFetchedResultsController<MoviesDataModel>!
    var moviesData: [MoviesDataModel]?
    private var manager: FavoritesManager?
    private var emptyMessage = UILabel.Factory.build(
        text: "Você ainda não tem nenhum favorito",
        textAlignment: .center,
        textStyle: .headline,
        numberOfLines: 0,
        accessibilityIdentifier: "emptyMessage",
        textColor: .white
    )
    
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
        setupBarButtonItem()
        moviesData = [MoviesDataModel]()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
        setupTableView()
    }
    
    private func setupBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.trash.fill"),
            style: .plain,
            target: self,
            action: #selector(removeAllFavorites)
        )
    }
    
    @objc
    private func removeAllFavorites() {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MoviesDataModel") // Find this name in your .xcdatamodeld file
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    private func setupTableView() {
        manager = FavoritesManager(
            moviesData: moviesData ?? [],
            fetchedResultsController: fetchedResultsController
        )
        tableView.delegate = manager
        tableView.dataSource = manager
        tableView.reloadData()
    }
    
    private func showEmptyMessage() {
        if let objects = fetchedResultsController.fetchedObjects,  objects.isEmpty {
            tableView.isHidden = true
            emptyMessage.isHidden = false
        } else {
            tableView.isHidden = false
            emptyMessage.isHidden = true
        }
    }
    
    func loadFavorites() {
        let fetchRequest: NSFetchRequest<MoviesDataModel> = MoviesDataModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "movieName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        do {
        try fetchedResultsController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        showEmptyMessage()
    }
}



extension FavoritesMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubviews(tableView, emptyMessage)
    }
    
    func setupConstraints() {
        tableView.bindFrameToSuperviewBounds()
        emptyMessage.bindFrameToSuperviewSafeBounds()
    }
    
    func setupAdditionalConfiguration() {
        configureNavigationBar(
            largeTitleColor: .white,
            backgoundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),
            tintColor: .white,
            title: "Favorites",
            preferredLargeTitle: true
        )
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
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
