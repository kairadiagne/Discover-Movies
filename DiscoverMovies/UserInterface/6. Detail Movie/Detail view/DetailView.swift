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
    
    // MARK: -  Properties
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
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
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var similarLabel: UILabel!
    @IBOutlet weak var similarMovieCollectionView: UICollectionView!
    @IBOutlet weak var readReviewsButton: UIButton!
    @IBOutlet weak var favouriteControl: FavouriteButton!
    @IBOutlet weak var watchListControl: WatchListButton!
    @IBOutlet weak var header: GradientImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var scrollTop: NSLayoutConstraint!
    @IBOutlet weak var headerTop: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var animationConstraint: NSLayoutConstraint!
    
    fileprivate var contentInsetTop: CGFloat = 0
    
    fileprivate var didSetContentInset = false
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
        contentView.backgroundColor = UIColor.backgroundColor()
        
        titleLabel.font = UIFont.H1()
        descriptionLabel.font = UIFont.Body()
        directorLabel.font = UIFont.H2()
        directorValueLabel.font = UIFont.Caption()
        releaseLabel.font = UIFont.H2()
        releaseValueLabel.font = UIFont.Caption()
        genreLabel.font = UIFont.H2()
        genreValueLabel.font = UIFont.Caption()
        ratingLabel.font = UIFont.H2()
        ratingValueLabel.font = UIFont.Caption()
        castLabel.font = UIFont.H2()
        similarLabel.font = UIFont.H2()
        
        favouriteControl.lineColor = UIColor.buttonColor()
        favouriteControl.fillColor = UIColor.buttonColor()
        watchListControl.lineColor = UIColor.buttonColor()
        watchListControl.fillColor = UIColor.buttonColor()
        
        readReviewsButton.backgroundColor = UIColor.clear
        readReviewsButton.setTitleColor(UIColor.buttonColor(), for: .normal)
        readReviewsButton.layer.borderColor = UIColor.buttonColor().cgColor
        readReviewsButton.layer.borderWidth = 1.5
        
        directorLabel.text = NSLocalizedString("directorLabelText", comment: "")
        genreLabel.text = NSLocalizedString("genreLabelText", comment: "")
        releaseLabel.text = NSLocalizedString("releaseLabelText", comment: "")
        ratingLabel.text =  NSLocalizedString("ratingLabelText", comment: "")
        
        header.clipsToBounds = true 
        
        // For animation
        header.alpha = 0.3
        playButton.alpha = 0.3
    }
    
    // MARK: - LifeCycle
   
    override func layoutSubviews() {
        super.layoutSubviews()
    
        if !didSetContentInset {
            didSetContentInset = true
            contentInsetTop =  ceil(header.bounds.size.height - scrollTop.constant)
            scrollView.contentInset.top = contentInsetTop
        }
        
        readReviewsButton.layer.cornerRadius = readReviewsButton.bounds.size.height / 2
    }
    
    // MARK: - Configure
    
    func configure(withMovie movie: Movie, signedIn: Bool) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        genreValueLabel.text = movie.mainGenre()?.name ?? NSLocalizedString("unknownGenreText", comment: "")
        ratingValueLabel.text =  "\(movie.rating)\\10.0"
        
        if let imageURL = TMDbImageRouter.backDropMedium(path: movie.backDropPath).url {
            header.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
        }
        
        if let releaseYear = movie.releaseDate.toDate()?.year() {
            releaseValueLabel.text = "\(releaseYear)"
        } else {
            releaseValueLabel.text = NSLocalizedString("unknownReleaseText", comment: "")
        }
        
        if !signedIn {
            favouriteControl.isHidden = true
            watchListControl.isHidden = true
        }
    }
    
    func configureWithState(_ inFavorites: Bool, inWatchList: Bool) {
        favouriteControl.setSelectedState(inFavorites)
        watchListControl.setSelectedState(inWatchList)
    }
    
    func configure(withDirector director: CrewMember?) {
        directorValueLabel.text = director?.name ?? NSLocalizedString("unknownDirectorText", comment: "")
    }
    
    // MARK: - Animation
    
    func animatePresentation() {
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
        let contentOffSetY = scrollView.contentOffset.y
        
        // Calculate the position of the header 
        // 1 means the header has collapsed
        // 0 Means the header is fully expanded
        let position = (contentInsetTop + contentOffSetY) / contentInsetTop
        let openHeader = min(1, max(0, position))
        
        // Adjust the header position
        headerTop.constant = openHeader * -header.bounds.height * 0.8
        
        // Adjust the alpha of the button
        // When header is collapsed the playbutton should not be visible
        playButton.alpha = -openHeader + 1
        
        // Adjust height of header 
        if contentOffSetY < -contentInsetTop {
            headerHeightConstraint.constant = abs(contentOffSetY) - contentInsetTop
        } else {
            headerHeightConstraint.constant = 0
        }
    }
    
}
