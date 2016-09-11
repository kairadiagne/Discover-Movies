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
    
    // MARK: Properties

    var cellIdentifier: String = MovieCollectionViewCell.defaultIdentfier()
    
    fileprivate var movies = [Movie]()
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.row]
        cell.configureWithMovie(movie)
        return cell
    }
    
    // MARk: - Update
    
    func updateWithMovies(_ movies: [Movie]) {
        self.movies = movies
    }
    
    func movieAtIndex(_ index: Int) -> Movie?{
        guard index >= 0 || index <= movies.count else { return nil }
        return movies[index]
    }
    
}
