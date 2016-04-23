//
//  ListTableViewCell.swift
//  
//
//  Created by Kaira Diagne on 14-03-16.
//
//

import UIKit
import TMDbMovieKit
import Cosmos
import SDWebImage

class ListTableViewCell: UITableViewCell {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.Body()
        self.overviewLabel.font = UIFont.Caption1()
        self.ratingView.setToDefaultStyle()
    }

}

// MARK: - Configure Methods

extension ListTableViewCell {
    
    func configure(movie: TMDbMovie, imageURL: NSURL?) {
        titleLabel.text = movie.title != nil ? movie.title! : "Unknown"
        overviewLabel.text = movie.overview != nil ? movie.overview! : ""
        if let rating = movie.rating { ratingView.configureForRating(rating) }
        movieImageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage.placeholderImage())
    }

}

