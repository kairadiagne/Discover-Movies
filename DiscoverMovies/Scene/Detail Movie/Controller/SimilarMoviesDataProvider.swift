//
//  SimilarMoviesDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SimilarMovieDataProvider: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private struct Constants {
        static let MovieCellIdentifier = "MovieCell"
    }
    
    var didSelectBlock: ((movie: TMDbMovie) -> ())?
    
    private var movies = [TMDbMovie]()
    
    private var collectionView: UICollectionView?
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView = collectionView
        return movies.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.MovieCellIdentifier,
                                                                         forIndexPath: indexPath) as! MovieCollectionViewCell
        // Configure cell with movie
        let movie = movies[indexPath.row]
        cell.configureWithMovie(movie)
        return cell
    }
    
    // MARk: - Update
    
    func updateWithMovies(movies: [TMDbMovie]) {
        self.movies = movies
        collectionView?.reloadData()
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let movie = movies[indexPath.row]
        didSelectBlock?(movie: movie)
    }
    
}