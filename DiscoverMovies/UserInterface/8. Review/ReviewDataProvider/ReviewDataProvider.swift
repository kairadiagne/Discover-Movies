//
//  ReviewDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class ReviewDataProvider: NSObject, DataProvider, UITableViewDataSource {
    
    // MARK: Properties
    
    typealias Item = Review
    typealias Cell = ReviewTableViewCell
    var items: [Item] = []
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! Cell
        let review = items[indexPath.row]
        cell.configure(review)
        return cell
    }
    
}
