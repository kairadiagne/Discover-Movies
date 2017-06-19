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
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCell.reuseId, for: indexPath) as! NoDataCell
            cell.configure(with: NSLocalizedString("topListNoDataCellText", comment: ""))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverListCell.reuseId, for: indexPath) as! DiscoverListCell
            let movie = items[indexPath.row]
            cell.configure(movie, imageURL: TMDbImageRouter.backDropMedium(path: movie.backDropPath).url)
            return cell
        }
    }

}


