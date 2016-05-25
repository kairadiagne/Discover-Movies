//
//  ListTableViewCell.swift
//  
//
//  Created by Kaira Diagne on 14-03-16.
//
//

import UIKit
import TMDbMovieKit
import SDWebImage

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.Body()
        self.overviewLabel.font = UIFont.Caption()
    }

}

// MARK: - Configure Methods

extension ListTableViewCell {
    
    func configure(movie: TMDbMovie, imageURL: NSURL?) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview != nil ? movie.overview! : ""
//        if let rating = movie.rating { ratingView.configureForRating(rating) }
        movieImageView.sd_setImageWithURL(imageURL, placeholderImage: UIImage.placeholderImage())
    }

}

