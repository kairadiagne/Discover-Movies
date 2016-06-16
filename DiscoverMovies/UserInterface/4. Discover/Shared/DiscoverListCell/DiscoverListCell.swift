//
//  DiscoverListCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class DiscoverListCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.H1()
        yearLabel.font = UIFont.H3()
    }
    
}

extension DiscoverListCell {
    
    func configure(movie: TMDbMovie, imageURL: NSURL?) {
        titleLabel.text = movie.title 
        yearLabel.text = movie.releaseDate != nil ? "\(movie.releaseDate!.year())": "Unknonwn"
        movieImageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage.placeholderImage())
    }
    
}

