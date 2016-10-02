//
//  TopListDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class TopListDataSource: NSObject, DataContaining, UITableViewDataSource {
    
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
            let message = NSLocalizedString("homeNoDataCellText", comment: "")
            cell.configure(with: message)
            return cell
        } else {
            let cellIdentifier = DiscoverListCell.defaultIdentifier()
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DiscoverListCell
            let movie = items[indexPath.row]
            let imageURL = TMDbImageRouter.backDropMedium(path: movie.backDropPath).url ?? nil
            cell.configure(movie, imageURL: imageURL)
            return cell
        }
    }

}


