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
    
    // MARK: - Properties
    
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
    @IBOutlet weak var readReviewsButton: DiscoverButton!
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
    
    fileprivate var defaultHeaderheight: CGFloat = 0
    
    fileprivate var didSetContentInset = false
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.backgroundColor()
        contentView.backgroundColor = UIColor.backgroundColor()
        
        titleLabel.font = UIFont.H1()
        titleLabel.textColor = UIColor.white
        
        descriptionLabel.font = UIFont.Body()
        descriptionLabel.textColor = UIColor.white
        
        directorLabel.font = UIFont.H2()
        directorLabel.textColor = UIColor.white
        
        directorValueLabel.font = UIFont.Caption()
        directorValueLabel.textColor = UIColor.white

        releaseLabel.font = UIFont.H2()
        releaseLabel.textColor = UIColor.white
        
        releaseValueLabel.font = UIFont.Caption()
        releaseValueLabel.textColor = UIColor.white
        
        genreLabel.font = UIFont.H2()
        genreLabel.textColor = UIColor.white
        
        genreValueLabel.font = UIFont.Caption()
        genreValueLabel.textColor = UIColor.white
        
        ratingLabel.font = UIFont.H2()
        ratingLabel.textColor = UIColor.white
        
        ratingValueLabel.font = UIFont.Caption()
        ratingValueLabel.textColor = UIColor.white
        
        castLabel.font = UIFont.H2()
        castLabel.textColor = UIColor.white
        
        similarLabel.font = UIFont.H2()
        similarLabel.textColor = UIColor.white
        
        favouriteControl.lineColor = UIColor.buttonColor()
        favouriteControl.fillColor = UIColor.buttonColor()
        watchListControl.lineColor = UIColor.buttonColor()
        watchListControl.fillColor = UIColor.buttonColor()
        
        directorLabel.text = NSLocalizedString("directorLabelText", comment: "")
        genreLabel.text = NSLocalizedString("genreLabelText", comment: "")
        releaseLabel.text = NSLocalizedString("releaseLabelText", comment: "")
        ratingLabel.text =  NSLocalizedString("ratingLabelText", comment: "")
        
        header.clipsToBounds = true 
        
        // For animation
        header.alpha = 0.3
        playButton.alpha = 0.3
        
        scrollView.contentInset.top = contentInsetTop
    }
    
    // MARK: - LifeCycle
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !didSetContentInset {
            didSetContentInset = true
            defaultHeaderheight = headerHeightConstraint.constant
            contentInsetTop = ceil(headerHeightConstraint.constant - scrollTop.constant)
            scrollView.contentInset.top = contentInsetTop
        }
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
        
        favouriteControl.isHidden = !signedIn
        watchListControl.isHidden = !signedIn
    }
    
    func configureWithState(_ inFavorites: Bool, inWatchList: Bool) {
        favouriteControl.setSelectedState(inFavorites)
        watchListControl.setSelectedState(inWatchList)
    }
    
    func configure(withDirector director: CrewMember?) {
        directorValueLabel.text = director?.name ?? NSLocalizedString("unknownDirectorText", comment: "")
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
        headerTop.constant = openHeader * -defaultHeaderheight * 0.8
        
        // Adjust header height
        if contentOffSetY < -contentInsetTop {
            headerHeightConstraint.constant = defaultHeaderheight + (abs(contentOffSetY) - contentInsetTop)
        } else {
            headerHeightConstraint.constant = defaultHeaderheight
        }
        
        // Adjust alpha play button
        playButton.alpha = -openHeader + 1
    }
    
}
