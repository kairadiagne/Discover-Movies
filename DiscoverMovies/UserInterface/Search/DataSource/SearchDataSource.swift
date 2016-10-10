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
        return itemCount // Later one more cell if empty that shows top search terms (popular searches cell)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountListTableViewCell.defaultIdentifier(), for: indexPath) as! AccountListTableViewCell
        let movie = items[indexPath.row]
        let imageURL = TMDbImageRouter.posterSmall(path: movie.posterPath).url
        cell.configure(movie, imageURL: imageURL)
        return cell
    }
    
}
