 //
//  DetailTableViewCell.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage
import TMDbMovieKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var watchListView: WatchListView!
    @IBOutlet weak var favoriteView: FavoriteView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var similarMoviesScroller: HorizontalImageScroller!
    @IBOutlet weak var watchTrailerButton: CustomButton!
    @IBOutlet weak var watchReviewButton: CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.font = UIFont.H1()
        self.releaseDateLabel?.font = UIFont.Caption1()
        self.genreLabel?.font = UIFont.Caption2()
        self.descriptionLabel?.font = UIFont.Body()
        self.ratingView?.setToDefaultStyle()
    }
    
    // MARK: - Animation 
    
    func prepareAnimation() {
        favoriteView.alpha = 0.0
        watchListView.alpha = 0.0
        movieImageView.alpha = 0.4
        watchTrailerButton.alpha = 0.0
        watchReviewButton.alpha = 0.0
    }
    
    func animate() {
        
        UIView.animateWithDuration(0.5) {
            self.movieImageView.alpha = 1.0
        }
        
        UIView.animateWithDuration(1.0, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [.CurveEaseInOut], animations: {
            self.favoriteView.alpha = 1.0
            self.watchListView.alpha = 1.0
            self.watchTrailerButton.alpha = 1.0
            self.watchReviewButton.alpha = 1.0
            }, completion: nil)
    }
        
}

// MARK: - Configure Methods

extension DetailTableViewCell {
    
    func configure(movie: TMDbMovie, image: UIImage?, url: NSURL?) {
        titleLabel.text = movie.title != nil ? movie.title! : "Unknown"
        releaseDateLabel.text = movie.releaseDate != nil ? movie.releaseDate!.toString(): "Unknown"
        descriptionLabel.text = movie.overview != nil ? movie.overview! : ""
        genreLabel.text = genreString(movie.genreStrings)
        
        ratingView.configureForRating(movie.rating)
        similarMoviesScroller.reloadData()
        
        if let image = image {
            configureForImage(image)
        } else if let url = url {
            configureForImageWithURL(url)
        }

    }
    
    func configureForAccountState(inFavorites: Bool?, inWatchList: Bool?) {
        if let inFavorites = inFavorites, inWatchList = inWatchList {
            favoriteView.inList = inFavorites
            watchListView.inList = inWatchList
        }
    }
    
    private func configureForImage(image: UIImage) {
        movieImageView.image = image
    }
    
    private func configureForImageWithURL(url: NSURL) {
        movieImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
    }
    
    private func genreString(genres: [String]? ) -> String {
        guard let genres = genres else { return "" }
        let string: NSMutableString = ""
        for genre in genres { string.appendString(" *\(genre) ") }
        return String(string)
    }

}
 
