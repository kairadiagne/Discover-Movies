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
    
    // MARK: Outlet Properties
    
    @IBOutlet weak var detailScrollView: UIScrollView!
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
    
    // MARK: Other Properties
    
    private var didAnimate = false
    
    private var topInset: CGFloat {
        return header.frame.height - scrollTop.constant
    }
    
    private var openHeader: CGFloat {
        let contentInsetY = detailScrollView.contentInset.top
        let contentOffSetY = detailScrollView.contentOffset.y
        let position = (contentInsetY + contentOffSetY) / contentInsetY
        return min(1, max(0, position))
    }
    
    // MARK: Setup UI
    
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
        self.readReviewsButton.layer.borderColor = UIColor.buttonColor().CGColor
        
        detailScrollView.delegate = self
        detailScrollView.bounces = false
        
        // Change for animation
        self.header.alpha = 0.3
        self.playButton.alpha = 0.3
    }
    
    // MARK: LifeCycle 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.detailScrollView.contentInset.top = topInset
    }

    // MARK: Configure
    
    func configure(withMovie movie: TMDbMovie, image: UIImage?) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview ?? "N/A"
        genreValueLabel.text = movie.genres.first?.name ?? "Unknown"
        ratingValueLabel.text = movie.rating != nil ? "\(movie.rating!)\\10.0" : "0.0\\10.0"
        releaseValueLabel.text = movie.releaseDate != nil ? "\(movie.releaseDate!.year())" : "Unknown"
        
        if let image = image {
            header.image = image
        }
        
        if let path = movie.backDropPath {
            let imageURL = TMDbImageRouter.BackDropMedium(path: path).url ?? NSURL()
            header.sd_setImageWithURL(imageURL, placeholderImage: UIImage.placeholderImage())
        }

    }
    
    func configure(withDirector director: TMDbCrewMember?, inFavorites: Bool, inWatchList: Bool) {
        directorValueLabel.text = director?.name ?? "Unknown"
        favouriteControl.setSelectedState(inFavorites)
        watchListControl.setSelectedState(inWatchList)
    }
    
    func reloadCollectionViews() {
        castCollectionView.reloadData()
        similarMovieCollectionView.reloadData()
    }
    
    // MARK: Animation
    
    func animateOnScreen() {
        if !didAnimate {
            didAnimate = true
            
            self.layoutIfNeeded()
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseInOut], animations: {
                self.animationConstraint.priority -= 2
                self.layoutIfNeeded()
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.3, options: [.CurveEaseInOut], animations: {
                self.header.alpha = 1.0
                }, completion: nil)
            
            UIView.animateWithDuration(0.2, delay: 0.6, options: [.CurveEaseInOut], animations: {
                self.playButton.alpha = 1.0
                }, completion: nil)
        }
    }
    
}

// MARK: - UIScrollViewDelegate

extension DetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        headerTop.constant = openHeader * -header.frame.height * 0.8
        playButton.alpha = -openHeader + 1
        detailScrollView.bounces = detailScrollView.contentOffset.y > topInset
    }
    
}


