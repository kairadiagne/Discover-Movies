//
//  ReviewDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

// TODO: - Show Background Message. How??

class ReviewDataProvider: NSObject, DataProvider, UITableViewDataSource {
    
    // MARK: Properties
    
    typealias Item = TMDbReview
    
    typealias Cell = ReviewTableViewCell
    
    var items: [Item] = []
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! Cell
        let review = items[indexPath.row]
        cell.configure(review)
        return cell
    }
    
}