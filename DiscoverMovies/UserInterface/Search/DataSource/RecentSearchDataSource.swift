//
//  SearchDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class RecentSearchDataSource: NSObject, DataContaining, UITableViewDataSource {
    
    typealias ItemType = String
    
    // MARK: - Properties 
    
    var items: [String] = []
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell() // fIXME: - Dequeue specifi cell
        let searchTerm = item(atIndex: indexPath.row)
        cell.textLabel?.text = searchTerm
        cell.textLabel?.tintColor = UIColor.white
        cell.textLabel?.font = UIFont.Caption()
        return cell
    }
    
}
