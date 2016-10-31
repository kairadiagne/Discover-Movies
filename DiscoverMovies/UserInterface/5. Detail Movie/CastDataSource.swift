//
//  CastDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class CastDataSource: NSObject, DataContaining, UICollectionViewDataSource {
    
    typealias ItemType = CastMember
    
    // MARK: - Properties 
    
    var items: [CastMember] = []
    
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.defaultIdentfier(), for: indexPath) as! PersonCollectionViewCell
            let castMember = items[indexPath.row]
            cell.configureWithCastMember(castMember)
            return cell
        }
    }

}
