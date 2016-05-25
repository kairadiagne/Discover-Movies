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

class DetailView: BackgroundView {
    
    private struct Constants {
        static let HeaderHeight: CGFloat = 291
    }
    
    // Static content
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var similarMoviesLabel: UILabel!

    // Dynamic content
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var directorValueLabel: UILabel!
    @IBOutlet weak var genreValueLabel: UILabel!
    @IBOutlet weak var releaseValueLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var similarMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var favouriteButton: FavouriteButton!
    @IBOutlet weak var watchListButton: WatchListButton!
    // Add to watch list button 
    // Watch Trailer button
    // Read reviews button 

    var headerImageView: GradientImageView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFontsForLabels()
        setUpButtons()
        setupCollectionView()
        setupHeaderImageView()
        setupScrollView()
        updateHeaderView()
    }
    
    private func setupFontsForLabels() {
        self.titleLabel?.font = UIFont.H1()
        self.overviewLabel?.font = UIFont.Body()
        self.releaseLabel.font = UIFont.H2()
        self.releaseValueLabel.font = UIFont.Caption()
        self.genreLabel.font = UIFont.H2()
        self.genreValueLabel.font = UIFont.Caption()
        self.ratingLabel.font = UIFont.H2()
        self.ratingValueLabel.font = UIFont.Caption()
        self.castLabel.font = UIFont.H2()
        self.similarMoviesLabel.font = UIFont.H2()
        self.directorLabel.font = UIFont.H2()
        self.directorValueLabel.font = UIFont.Caption()
    }
    
    private func setUpButtons() {
        favouriteButton.lineColor = UIColor.buttonColor()
        favouriteButton.fillColor = UIColor.buttonColor()
        watchListButton.lineColor = UIColor.buttonColor()
        watchListButton.fillColor = UIColor.buttonColor()
    }
    
    private func setupCollectionView() {
        // Assign custom flow layout
        self.similarMoviesCollectionView.collectionViewLayout = DetailFlowLayout()
        self.castCollectionView.collectionViewLayout = DetailFlowLayout()       
    }
    
    private func setupScrollView() {
        self.detailScrollView.delegate = self
        self.detailScrollView.contentInset = UIEdgeInsets(top: Constants.HeaderHeight, left: 0, bottom: 0, right: 0)
        self.detailScrollView.contentOffset = CGPoint(x: 0, y: -Constants.HeaderHeight)
    }
    
    private func setupHeaderImageView() {
        let frame = CGRect(x: 0, y: 0, width: bounds.width, height: Constants.HeaderHeight)
        let gradientColors = [UIColor.backgroundColor().CGColor, UIColor.clearColor().CGColor]
        let startPoint = CGPoint(x: 0, y: 1)
        let endPoint = CGPoint(x: 0, y: 0.1)
        self.headerImageView = GradientImageView(gradientColors: gradientColors, startPoint: startPoint, endPoint: endPoint)
        self.headerImageView.contentMode = .ScaleAspectFill
        self.headerImageView.frame = frame
        self.contentView.addSubview(headerImageView)
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame.size.width = self.bounds.width
    }
    
    // MARK: - Header

    func updateHeaderView() {
        // Get the current size of the header
        var headerRect = CGRect(x: 0, y: -Constants.HeaderHeight, width: detailScrollView.bounds.width, height: Constants.HeaderHeight)
        
        // If the scroll view offset is greater than the header height adjust the header rect
        if detailScrollView.contentOffset.y < -Constants.HeaderHeight {
            headerRect.origin.y = detailScrollView.contentOffset.y
            headerRect.size.height = -detailScrollView.contentOffset.y
        }
        
        // Update header image view frame
        headerImageView.frame = headerRect
    }
    
    // MARK: - Configure Methods
  
    func configureForMovie(movie: TMDbMovie, image: UIImage? = nil, url: NSURL? = nil) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview ?? "N/A"
//        genreValueLabel.text = movie.genreStrings.count > 0 ? "\(movie.genreStrings.first!)" : "Unknown"
        ratingValueLabel.text = "\(movie.rating!)\\10.0"
        releaseValueLabel.text = movie.releaseDate != nil ? "\(movie.releaseDate!.year())" : "Unknown"
        setImage(image, url: url)
    }
    
    func configureWithMovieCredit(movieCredit: TMDbMovieCredit) {
        directorValueLabel.text = movieCredit.director?.name != nil ? movieCredit.director?.name! : nil
    }
    
    func configureForStatus(inFavorites: Bool, inWatchList: Bool) {
        // favorite button highlighted
        // watchlist button highlighted
    }
    
    // MARK: - Helper functions
    
    private func setImage(image: UIImage?, url: NSURL?) {
        if let image = image {
           headerImageView.image = image
        } else if let url = url {
           headerImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
        }
        
    }

}

// MARK: - UIScrollViewDelegate

extension DetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
}


    

    










