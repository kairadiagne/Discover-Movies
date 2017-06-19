//
//  CastDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class CastDataSource: BaseCollectionViewDataSource<CastMember, PersonCollectionViewCell> {

    override func configure(_ cell: PersonCollectionViewCell, atIndexPath indexPath: IndexPath) {
        let castMember = items[indexPath.row]
        cell.configureWithCastMember(castMember)
    }
    
}
