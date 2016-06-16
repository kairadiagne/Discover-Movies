//
//  AccountListDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/06/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class AccountListDataProvider: NSObject, DataProvider, UITableViewDataSource {
    
    // MARK: Properties
    
    typealias Item = TMDbMovie
    
    typealias Cell = AccountListTableViewCell
    
    var items: [Item] = []
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! Cell
        let movie = items[indexPath.row]
        let imageURL = movie.posterPath != nil ? TMDbImageRouter.BackDropMedium(path: movie.posterPath!).url: nil 
        cell.configure(movie, imageURL: imageURL)
        return cell
    }
    
}

