//
//  FavoritesManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/04/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import Foundation
import CoreData

final class FavoritesManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    var moviesData: [MoviesDataModel]
    var fetchedResultsController: NSFetchedResultsController<MoviesDataModel>
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    init(moviesData: [MoviesDataModel],
         fetchedResultsController: NSFetchedResultsController<MoviesDataModel>)
    {
        self.moviesData = moviesData
        self.fetchedResultsController = fetchedResultsController
    }
    
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
