//
//  MovieCollectionDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MovieCollectionDataSource: NSObject, DataContaining, UICollectionViewDataSource {
    
    typealias ItemType = MovieRepresentable
    
    // MARK: - Properties 
    
    var items: [MovieRepresentable] = []
    
    private let emptyMessage: String
    
    // MARK: - Initialize
    
    init(emptyMessage: String) {
        self.emptyMessage = emptyMessage
        super.init()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !isEmpty ? itemCount : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCollectionViewCell.reuseId, for: indexPath) as! NoDataCollectionViewCell
            cell.configure(with: emptyMessage)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseId, for: indexPath) as! MovieCollectionViewCell
            let movie = items[indexPath.row]
            cell.configureWithMovie(movie)
            return cell
        }
    }
    
}
