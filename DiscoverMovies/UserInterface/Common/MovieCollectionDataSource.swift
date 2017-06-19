//
//  MovieCollectionDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MovieCollectionDataSource: BaseCollectionViewDataSource<MovieRepresentable, MovieCollectionViewCell> {
    
    override func configure(_ cell: MovieCollectionViewCell, atIndexPath indexPath: IndexPath) {
        let item = items[indexPath.row]
        cell.configureWithMovie(item)
    }

}
