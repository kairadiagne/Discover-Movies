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
    
    // MARK: - IB Outlets
    
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
    
    // MARK: - Initializers

    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel?.font = UIFont.H1()
        self.releaseDateLabel?.font = UIFont.Caption1()
        self.genreLabel?.font = UIFont.Caption2()
        self.descriptionLabel?.font = UIFont.Body()
        self.ratingView?.setToDefaultStyle()
    }
    
}

// MARK: - Configure Method

extension DetailTableViewCell {
    
    func configure(movie: TMDbMovie, image: UIImage?, url: NSURL?) {
        titleLabel.text = movie.title != nil ? movie.title! : "Unknown"
        releaseDateLabel.text = movie.releaseDate != nil ? "\(movie.releaseDate!)": "Unknown"
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