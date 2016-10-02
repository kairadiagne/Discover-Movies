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
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.defaultIdentfier(), for: indexPath) as! MovieCollectionViewCell
        let movie = items[indexPath.row]
        cell.configureWithMovie(movie)
        return cell
        // Show empty background message
    }
    
}
