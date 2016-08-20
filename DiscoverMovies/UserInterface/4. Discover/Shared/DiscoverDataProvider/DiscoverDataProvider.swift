//
//  BaseDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class DiscoverDataProvider: NSObject, DataProvider, UITableViewDataSource {
    
    // MARK: Properties
    
    typealias Item = Movie
    
    typealias Cell = DiscoverListCell
    
    var items: [Item] = []
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! Cell
        let movie = items[indexPath.row]
        let imageURL = TMDbImageRouter.BackDropMedium(path: movie.backDropPath).url ?? nil
        cell.configure(movie, imageURL: imageURL)
        return cell
    }
    
}





