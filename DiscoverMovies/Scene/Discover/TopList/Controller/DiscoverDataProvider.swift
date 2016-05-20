//
//  BaseDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class DiscoverDataProvider: NSObject, UITableViewDataSource {
    
    var cellIdentifier: String = ""
    
    // MARK: - Data
     
    private var movies: [TMDbMovie] = []
    
    var movieCount: Int {
        return movies.count
    }
    
    func movieAtIndex(index: Int) -> TMDbMovie? {
        guard index >= 0 && index <= movieCount else { return nil }
        return movies[index]
    }
    
    func updateMovies(movies: [TMDbMovie]) {
        self.movies = movies
    }
    
    // MARL: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! DiscoverListCell
        let movie = movies[indexPath.row]
        let imageURL = movie.backDropPath != nil ? TMDbImageRouter.BackDropMedium(path: movie.backDropPath!).url: nil 
        cell.configure(movie, imageURL: imageURL)
        return cell
    }
    
}



