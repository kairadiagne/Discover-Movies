//
//  TopListDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

final class MovieListDataSource: BaseCollectionViewDataSource<Movie, MovieBackdropCell> {
    
    override init(emptyMessage: String? = nil) {
        super.init(emptyMessage: emptyMessage)
    }
    
    override func configure(_ cell: MovieBackdropCell, atIndexPath indexPath: IndexPath) {
        let viewModel = MovieBackDropCellViewModel(movie: items[indexPath.row])
        cell.configure(with: viewModel)
    }
}
