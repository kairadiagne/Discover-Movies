//
//  PersonDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class CastDataProvider: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var cellIdentifier = ""
    
    var count: Int {
        return movieCredit?.cast.count ?? 0
    }
    
    private var movieCredit: TMDbMovieCredit?
    
    private var collectionView: UICollectionView?
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView = collectionView
        return movieCredit?.cast.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! PersonCollectionViewCell
        guard let castMember = movieCredit?.cast[indexPath.row] else { return cell }
        cell.configureWithCastMember(castMember)
        return cell
    }
    
    // MARk: - Update
    
    func updateWithMovieCredit(movieCredit credit: TMDbMovieCredit) {
        movieCredit = credit
        collectionView?.reloadData()
    }
    
}


