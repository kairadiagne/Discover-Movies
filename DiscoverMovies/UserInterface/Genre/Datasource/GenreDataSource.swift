//
//  GenreDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

class GenreDataSource: NSObject, DataContaining, UITableViewDataSource {
    
    typealias ItemType = Movie

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
