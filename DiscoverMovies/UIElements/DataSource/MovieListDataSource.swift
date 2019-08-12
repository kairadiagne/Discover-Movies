//
//  TopListDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MovieListDataSource: BaseTableViewDataSource<Movie, DiscoverListCell> {
    
    override init(emptyMessage: String = "topListNoDataCellText".localized) {
        super.init(emptyMessage: emptyMessage)
    }
    
    override func configure(_ cell: DiscoverListCell, atIndexPath indexPath: IndexPath) {
        let movie = items[indexPath.row]
        cell.configure(movie, imageURL: TMDbImageRouter.backDropMedium(path: movie.backDropPath).url)
    }
}
