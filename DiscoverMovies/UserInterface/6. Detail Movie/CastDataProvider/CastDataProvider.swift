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
        return movieCredit?.cast.count ?? 0
    }
    
    var cellIdentifier: String
    
    // MARK: Initializer
    
    init(cellIdentifier: String) {
        self.cellIdentifier = cellIdentifier
    }
    
    private var movieCredit: TMDbMovieCredit?
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCredit?.cast.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PersonCollectionViewCell
        guard let castMember = movieCredit?.cast[indexPath.row] else { return cell }
        cell.configureWithCastMember(castMember)
        return cell
    }
    
    // MARK: Update
    
    func updateWithMovieCredit(credit: TMDbMovieCredit) {
        movieCredit = credit
    }
    
}
