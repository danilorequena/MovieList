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
        guard let model = fetchedResultsController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            guard let favorite = self.fetchedResultsController.fetchedObjects?[indexPath.row] else { return }
            self.context.delete(favorite)
             try? self.context.save()
        default:
            break
        }
    }
    
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
    
}
