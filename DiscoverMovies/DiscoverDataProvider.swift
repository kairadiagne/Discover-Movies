//
//  BaseDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

// TODO: - Can be called MovieListDataProvider 

class DiscoverDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var didSelectBlock: ((movie: TMDbMovie) -> ())?
    var loadMoreBlock: (() -> ())?
    
    var cellIdentifier: String = ""
    
    // MARK: - Data
     
    private var movies: [TMDbMovie] = []
    
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
        // This should change
        let imageURL = movie.backDropPath != nil ? TMDbImageRouter.BackDropMedium(path: movie.backDropPath!).url: nil
        cell.configure(movie, imageURL: imageURL)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = movies[indexPath.row]
        didSelectBlock?(movie: movie)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if movies.count - 5 == indexPath.row {
            loadMoreBlock?()
        }
        
    }
}



