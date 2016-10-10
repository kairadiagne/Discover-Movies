//
//  SimilarMovieDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SimilarMovieDataSource: NSObject, DataContaining, UICollectionViewDataSource {
    
    typealias ItemType = Movie
    
    // MARK: - Properties 
    
    var items: [Movie] = []
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !isEmpty ? itemCount : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCollectionViewCell.defaultIdentfier(), for: indexPath) as! NoDataCollectionViewCell
            let message = NSLocalizedString("noSimilarMoviesText", comment: "")
            cell.configure(with: message)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.defaultIdentfier(), for: indexPath) as! MovieCollectionViewCell
            let movie = items[indexPath.row]
            cell.configureWithMovie(movie)
            return cell
        }
    }
    
}
