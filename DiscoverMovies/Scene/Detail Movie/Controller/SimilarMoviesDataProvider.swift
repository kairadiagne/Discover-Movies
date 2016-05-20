//
//  SimilarMoviesDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SimilarMovieDataProvider: NSObject, UICollectionViewDataSource {

    var cellIdentifier = ""
    
    private var movies = [TMDbMovie]()
    
    private var collectionView: UICollectionView?
    
    func movieAtIndex(index: Int) -> TMDbMovie? {
        guard index >= 0 || index <= movies.count else { return nil }
        return movies[index]
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView = collectionView
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.row]
        cell.configureWithMovie(movie)
        return cell
    }
    
    // MARk: - Update
    
    func updateWithMovies(movies: [TMDbMovie]) {
        self.movies = movies
        collectionView?.reloadData()
    }
    
    
}