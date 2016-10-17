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
    
    // MARK: - Properties

    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: - Configure
    
    func configureWithMovie(_ movie: Movie) {
        guard let url = TMDbImageRouter.posterMedium(path: movie.posterPath).url else { return }
        movieImageView.sd_setImage(with: url, placeholderImage: UIImage.placeholderImage())
    }
    
    // MARK: - Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieImageView.image = nil
    }
}
