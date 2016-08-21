//
//  MovieCollectionViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties

    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: Configure
    
    func configureWithMovie(movie: Movie) {
        guard let url = TMDbImageRouter.PosterMedium(path: movie.posterPath).url else { return }
        movieImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
    }
}
