//
//  FavoritesMoviesDatasource.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit
import CoreData


final class FavoritesMoviesDatasource: NSObject, UITableViewDataSource {
    private var movies: [MoviesDataModel]
    var fetchedResultsController: NSFetchedResultsController<MoviesDataModel>!
    
    init(movies: [MoviesDataModel]) {
        self.movies = movies
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchedResultsController.fetchedObjects?.count ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesMoviesCell.identifier(), for: indexPath) as! FavoritesMoviesCell
        guard let model = fetchedResultsController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        cell.model = model
        cell.delegate = self
        return cell
    }
}

extension FavoritesMoviesDatasource: FavoritesDelegate {
    func didTapCell(model: MoviesDataModel) {
        
    }
}


