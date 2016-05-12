//
//  DetailView.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage
import Cosmos

class DetailView: UIView {
    
    private struct Constants {
        static let HeaderHeight: CGFloat = 250
    }
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: CosmosView!
    // Favorite button
    // Add to watch list button 
    // Watch Trailer button
    // Read reviews button 
   
    var headerImageView: UIImageView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        // Configure labels
        // TODO: Change font style throughout app
        self.titleLabel?.font = UIFont.H1()
        self.genreLabel?.font = UIFont.Caption2()
        self.overviewLabel?.font = UIFont.Body()
        self.ratingLabel.setToDefaultStyle()
        
        // Setup header image
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: Constants.HeaderHeight)
        headerImageView = UIImageView(frame: frame)
        headerImageView.contentMode = .ScaleAspectFill
        contentView.addSubview(headerImageView)
        
        // Setup the scrollview
        // Adjust contentInset: The distance that the contentview is inset from the enclosing scroll view (padding)
        // Adjust the contentOffset: the point at which the origin of the content view is offset from the origin of the scroll view
        detailScrollView.delegate = self
        detailScrollView.contentInset = UIEdgeInsets(top: Constants.HeaderHeight, left: 0, bottom: 0, right: 0)
        detailScrollView.contentOffset = CGPoint(x: 0, y: -Constants.HeaderHeight)
    
        updateHeaderView()
    }
    
    // MARK: - View Configuration
    
    // Parallax scroll effect 
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -Constants.HeaderHeight, width: detailScrollView.bounds.width, height: Constants.HeaderHeight)
        
        // Parelax scrolling effect
        if detailScrollView.contentOffset.y < -Constants.HeaderHeight {
            headerRect.origin.y = detailScrollView.contentOffset.y
            headerRect.size.height = -detailScrollView.contentOffset.y
        }
        
        headerImageView.frame = headerRect
    }
    
    func configureForMovie(movie: TMDbMovie, image: UIImage) {
        titleLabel.text = movie.title! + "(movie.releaseDate?.year())" ?? "Unknown"
        genreLabel.text = genreString(movie.genreStrings)
        overviewLabel.text = movie.overview ?? "N/A"
        ratingLabel.configureForRating(movie.rating)
        headerImageView.image = image
    }
    
    func configureWithMovieCredits(credits: String) {
        
    }
    
    func configureFor(status: Bool, status2: Bool) {
        
    }
    
    func configureForSimilarMovies(movies: [TMDbMovie]) {
        
    }
    
    func configureForPersons(person: [TMDbPerson]) {
        
    }
    
    private func configureForImage(image: UIImage) {
//        movieImageView.image = image
    }
    
    private func configureForImageWithURL(url: NSURL) {
//        movieImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
    }
    
    private func genreString(genres: [String]? ) -> String {
        guard let genres = genres else { return "" }
        let string: NSMutableString = ""
        for genre in genres { string.appendString(" *\(genre) ") }
        return String(string)
    }

}

// MARK: - UIScrollViewDelegate

extension DetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
}
