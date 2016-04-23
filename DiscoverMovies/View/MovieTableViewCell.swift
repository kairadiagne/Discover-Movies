//
//  MovieTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.H1()
        yearLabel.font = UIFont.H3()
    }
    
}

extension MovieTableViewCell {
    
    func configure(movie: TMDbMovie, imageURL: NSURL?) {
        titleLabel.text = movie.title != nil ? movie.title! : "Unknown"
        let yearOfRelease = movie.releaseDate?.year()
        yearLabel.text = yearOfRelease != nil ? "\(yearOfRelease!)": "Unknonwn"
        movieImageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage.placeholderImage())
    }
    
}

