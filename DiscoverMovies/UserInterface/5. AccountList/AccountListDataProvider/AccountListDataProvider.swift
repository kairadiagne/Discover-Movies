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
    
    typealias Item = Movie
    
    typealias Cell = AccountListTableViewCell
    
    var items: [Item] = []
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! Cell
        let movie = items[indexPath.row]
        // let imageURL = TMDbImageRouter.posterSmall(path: movie.posterPath).url ?? URL()
        // cell.configure(movie, imageURL: imageURL)
        return cell
    }
    
}

