//
//  MovieCollectionDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MovieCollectionDataSource: BaseCollectionViewDataSource<MovieRepresentable, PosterImageCollectionViewCell> {
    
    override func configure(_ cell: PosterImageCollectionViewCell, atIndexPath indexPath: IndexPath) {
        let viewModel = MoviePosterCellViewModel(movie: items[indexPath.row])
        cell.configure(with: viewModel)
    }
}
