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

    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Configure Cell
    
    func configureWithMovie(movie: TMDbMovie) {
        guard let path = movie.posterPath else { return }
        guard let url = TMDbImageRouter.PosterMedium(path: path).url else { return }
        movieImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
    }
}
