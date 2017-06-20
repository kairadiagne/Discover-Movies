//
//  SearchDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SearchDataSource: BaseTableViewDataSource<Movie, SearchTableViewCell> {
    
    override func configure(_ cell: SearchTableViewCell, atIndexPath indexPath: IndexPath) {
        let movie = items[indexPath.row]
        let imageURL = TMDbImageRouter.posterSmall(path: movie.posterPath).url
        cell.configure(withMovie: movie, imageURL: imageURL)
    }

}
