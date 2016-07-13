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
    
    private var castMembers: [TMDbCastMember]?
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castMembers?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PersonCollectionViewCell
        guard let castMember = castMembers?[indexPath.row] else { return cell }
        cell.configureWithCastMember(castMember)
        return cell
    }
    
    // MARK: Update
    
    func updateWithCast(castMembers: [TMDbCastMember]) {
        self.castMembers = castMembers
    }
    
}

