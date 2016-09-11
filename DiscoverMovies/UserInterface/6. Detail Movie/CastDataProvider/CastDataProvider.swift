//
//  PersonDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class CastDataProvider: NSObject, UICollectionViewDataSource {
    
    // MARK: Properties
    
    var count: Int {
        return castMembers?.count ?? 0
    }
    
    var cellIdentifier: String = PersonCollectionViewCell.defaultIdentfier()
    
    fileprivate var castMembers: [CastMember]?
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castMembers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PersonCollectionViewCell
        guard let castMember = castMembers?[indexPath.row] else { return cell }
        cell.configureWithCastMember(castMember)
        return cell
    }
    
    // MARK: Update
    
    func updateWithCast(_ castMembers: [CastMember]) {
        self.castMembers = castMembers
    }
    
}

