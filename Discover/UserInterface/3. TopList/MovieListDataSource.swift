//
//  TopListDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MovieListDataSource: NSObject, DataContaining, UITableViewDataSource {
    
    typealias ItemType = Movie
    
    // MARK: - Properties
    
    var items: [Movie] = []
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !isEmpty ? itemCount : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEmpty {
            let cellIdentifier = NoDataCell.defaultIdentifier()
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NoDataCell
            let message = NSLocalizedString("topListNoDataCellText", comment: "") // Change with init 
            cell.configure(with: message)
            return cell
        } else {
            let cellIdentifier = DiscoverListCell.defaultIdentifier()
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DiscoverListCell
            let movie = items[indexPath.row]
            let imageURL = TMDbImageRouter.backDropMedium(path: movie.backDropPath).url
            cell.configure(movie, imageURL: imageURL)
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


