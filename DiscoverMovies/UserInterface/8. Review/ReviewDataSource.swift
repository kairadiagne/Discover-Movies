//
//  ReviewdataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class ReviewDataSource: BaseTableViewDataSource<Review, ReviewTableViewCell> {
    
    override func configure(_ cell: ReviewTableViewCell, atIndexPath indexPath: IndexPath) {
        let review = items[indexPath.row]
        cell.configure(review)
    }
    
}
