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
    
    // MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    // MARK: Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.H1()
        yearLabel.font = UIFont.H3()
    }
    
    // MARK: Configure
    
    func configure(movie: Movie, imageURL: NSURL?) {
        titleLabel.text = movie.title
        
        if let releaseYear = movie.releaseDate.toDate()?.year() {
            yearLabel.text = "\(releaseYear)"
        } else {
            yearLabel.text = "Unknown"
        }
        
        movieImageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage.placeholderImage())
    }
    
}

