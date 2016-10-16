//
//  SearchDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SearchDataSource: NSObject, DataContaining, UITableViewDataSource {
    
    typealias ItemType = Movie
    
    // MARK: - Properties 
    
    var items: [Movie] = []
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !isEmpty ? itemCount : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEmpty {
            return noDataCell(withMessage: "Search Movies", forTableView: tableView, indexPath: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.defaultIdentifier(), for: indexPath) as! SearchTableViewCell
            let movie = items[indexPath.row]
            let imageURL = TMDbImageRouter.posterSmall(path: movie.posterPath).url
            cell.configure(withMovie: movie, imageURL: imageURL)
            return cell
        }
    }
    
    // TODO: - Create basic datasource which configures a nodatacell
    
    func noDataCell(withMessage message: String, forTableView tableView: UITableView, indexPath: IndexPath) -> NoDataCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.defaultIdentifier(), for: indexPath) as! NoDataCell
        cell.configure(with: message)
        return cell
    }
    
}
