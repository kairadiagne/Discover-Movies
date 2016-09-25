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
    
    // MARK: -  Properties
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: BackgroundView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var directorValueLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var genreValueLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var releaseValueLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var castCollectionView: BaseCollectionView!
    @IBOutlet weak var similarLabel: UILabel!
    @IBOutlet weak var similarMovieCollectionView: BaseCollectionView!
    @IBOutlet weak var readReviewsButton: UIButton!
    @IBOutlet weak var favouriteControl: FavouriteButton!
    @IBOutlet weak var watchListControl: WatchListButton!
    @IBOutlet weak var header: GradientImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var animationConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollTop: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerTop: NSLayoutConstraint!

    fileprivate var didAnimate = false
    
    fileprivate var topInset: CGFloat {
        return header.frame.height - scrollTop.constant
    }
    
    fileprivate var openHeader: CGFloat {
        let contentInsetY = scrollView.contentInset.top
        let contentOffSetY = scrollView.contentOffset.y
        let position = (contentInsetY + contentOffSetY) / contentInsetY
        return min(1, max(0, position))
    }
    
    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont.H1()
        self.descriptionLabel.font = UIFont.Body()
        self.directorLabel.font = UIFont.H2()
        self.directorValueLabel.font = UIFont.Caption()
        self.releaseLabel.font = UIFont.H2()
        self.releaseValueLabel.font = UIFont.Caption()
        self.genreLabel.font = UIFont.H2()
        self.genreValueLabel.font = UIFont.Caption()
        self.ratingLabel.font = UIFont.H2()
        self.ratingValueLabel.font = UIFont.Caption()
        self.castLabel.font = UIFont.H2()
        self.similarLabel.font = UIFont.H2()
        
        self.favouriteControl.lineColor = UIColor.buttonColor()
        self.favouriteControl.fillColor = UIColor.buttonColor()
        self.watchListControl.lineColor = UIColor.buttonColor()
        self.watchListControl.fillColor = UIColor.buttonColor()
        
        self.readReviewsButton.tintColor = UIColor.buttonColor()
        self.readReviewsButton.layer.borderWidth = 1.5
        self.readReviewsButton.layer.borderColor = UIColor.buttonColor().cgColor
        
        scrollView.bounces = false
        
        // For animation
        self.header.alpha = 0.3
        self.playButton.alpha = 0.3
    }
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.contentInset.top = topInset
    }

    // MARK: - Configure
    
    func configure(withMovie movie: Movie) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        genreValueLabel.text = movie.mainGenre()?.name ?? "Unknown"
        ratingValueLabel.text =  "\(movie.rating)\\10.0"
        
        if let imageURL = TMDbImageRouter.backDropMedium(path: movie.backDropPath).url {
            header.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
        }
        
        if let releaseYear = movie.releaseDate.toDate()?.year() {
            releaseValueLabel.text = "\(releaseYear)"
        } else {
            releaseValueLabel.text = "Unknown"
        }
    }
    
    func configureWithState(_ inFavorites: Bool, inWatchList: Bool) {
        favouriteControl.setSelectedState(inFavorites)
        watchListControl.setSelectedState(inWatchList)
    }
    
    func configure(withDirector director: CrewMember?) {
        directorValueLabel.text = director?.name ?? "Unknown"
    }
    
    // MARK: Animation
    
    func animateOnScreen() {
        self.layoutIfNeeded()
            
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions(), animations: {
            self.animationConstraint.priority -= 2
            self.layoutIfNeeded()
        }, completion: nil)
            
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions(), animations: {
            self.header.alpha = 1.0
        }, completion: nil)
            
        UIView.animate(withDuration: 0.2, delay: 0.6, options: UIViewAnimationOptions(), animations: {
            self.playButton.alpha = 1.0
        }, completion: nil)
    }
    
    // MARK: - Header
    
    func moveHeaderOnScroll() {
        headerTop.constant = openHeader * -header.frame.height * 0.8
        playButton.alpha = -openHeader + 1
        scrollView.bounces = scrollView.contentOffset.y > topInset
    }
    
}
