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

class DetailView: UIView {
    
    private struct Constants {
        static let HeaderHeight: CGFloat = 291
    }

    // Dynamic content
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // Static labels
    @IBOutlet weak var releaseDateTitleLabel: UILabel!
    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var similarMoviesLabel: UILabel!
    
    // Favorite button
    // Add to watch list button 
    // Watch Trailer button
    // Read reviews button 
    
    var gradientImageView: GradientView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        // Configure labels
        self.titleLabel?.font = UIFont.H3()
        self.genreLabel?.font = UIFont.Caption2()
        self.overviewLabel?.font = UIFont.Body()
        self.castLabel?.font = UIFont.Caption1()
        self.similarMoviesLabel?.font = UIFont.Caption1()
       
        // Setup Header Gradient ImageView
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: Constants.HeaderHeight)
        let gradientColors = [Theme.BaseColors.BackgroundColor.CGColor, UIColor.clearColor().CGColor]
        self.gradientImageView = GradientView(frame: frame, gradientColors: gradientColors)
        self.contentView.addSubview(gradientImageView)
       
        // Setup the scrollview
        self.detailScrollView.delegate = self
        self.detailScrollView.contentInset = UIEdgeInsets(top: Constants.HeaderHeight, left: 0, bottom: 0, right: 0)
        self.detailScrollView.contentOffset = CGPoint(x: 0, y: -Constants.HeaderHeight)
        
        self.updateHeaderView()
    }
    
    // MARK: - View Configuration

    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -Constants.HeaderHeight, width: detailScrollView.bounds.width, height: Constants.HeaderHeight)
        
        // Parelax scrolling effect
        if detailScrollView.contentOffset.y < -Constants.HeaderHeight {
            headerRect.origin.y = detailScrollView.contentOffset.y
            headerRect.size.height = -detailScrollView.contentOffset.y
        }

        gradientImageView.frame = headerRect
    }
  
    func configureForMovie(movie: TMDbMovie, image: UIImage) {
        titleLabel.text = movie.title! ?? "Unknown"
        genreLabel.text = "" // Implement in genre 
        overviewLabel.text = movie.overview ?? "N/A"
        gradientImageView.image = image
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
//        movieImageView.image = image5
    }
    
    private func configureForImageWithURL(url: NSURL) {
//        movieImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
    }
    
}

// MARK: - UIScrollViewDelegate

extension DetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
}


    
    
    










