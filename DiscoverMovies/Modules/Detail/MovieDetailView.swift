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

final class MovieDetailView: UIView {
    
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
    @IBOutlet weak var seeAllButton: UIButton!
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
   
    private var contentInsetTop: CGFloat = 0
    
    private var defaultHeaderheight: CGFloat = 0
    
    private var didSetContentInset = false
    
    // MARK: - Awake

    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .backgroundColor()
        contentView.backgroundColor = .backgroundColor()
        
        titleLabel.font = UIFont.H1()
        titleLabel.textColor = .white
        
        descriptionLabel.font = UIFont.Body()
        descriptionLabel.textColor = UIColor.white
        
        directorLabel.font = UIFont.H2()
        directorLabel.textColor = .white
        
        directorValueLabel.font = UIFont.Caption()
        directorValueLabel.textColor = .white

        releaseLabel.font = UIFont.H2()
        releaseLabel.textColor = .white
        
        releaseValueLabel.font = UIFont.Caption()
        releaseValueLabel.textColor = .white
        
        genreLabel.font = UIFont.H2()
        genreLabel.textColor = .white
        
        genreValueLabel.font = UIFont.Caption()
        genreValueLabel.textColor = .white
        
        ratingLabel.font = UIFont.H2()
        ratingLabel.textColor = .white
        
        ratingValueLabel.font = UIFont.Caption()
        ratingValueLabel.textColor = .white
        
        castLabel.font = UIFont.H2()
        castLabel.textColor = .white
        
        similarLabel.font = UIFont.H2()
        similarLabel.textColor = .white
        
        favouriteControl.lineColor = .buttonColor()
        favouriteControl.fillColor = .buttonColor()
        watchListControl.lineColor = .buttonColor()
        watchListControl.fillColor = .buttonColor()
        
        backButton.tintColor = .white
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        backButton.setTitle("backButtonTitle".localized, for: .normal)
        
        directorLabel.text = "directorLabelText".localized
        genreLabel.text = "genreLabelText".localized
        releaseLabel.text = "releaseLabelText".localized
        ratingLabel.text =  "ratingLabelText".localized
        
        seeAllButton.setTitle("seeAllButtonText".localized, for: .normal)
        seeAllButton.setTitleColor(.white, for: .normal)
        seeAllButton.isHidden = true
        
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
    
    func configure(forSignIn signedIn: Bool) {
        favouriteControl.isHidden = !signedIn
        watchListControl.isHidden = !signedIn
    }
    
    func configure(forMovie movie: Movie) {
        titleLabel.text = movie.title
        descriptionLabel.text = !movie.overview.isEmpty ? movie.overview : "noDescriptionText".localized
        genreValueLabel.text = movie.mainGenre?.name ?? "unknownGenreText".localized
        ratingValueLabel.text =  "\(movie.rating)\\10.0"
        
        if let releaseYear = movie.releaseDate.toDate()?.year() {
            releaseValueLabel.text = "\(releaseYear)"
        } else {
            releaseValueLabel.text = "unknownReleaseText".localized
        }
        
        if let imageURL = TMDbImageRouter.backDropMedium(path: movie.backDropPath).url {
            header.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
        } else {
            header.image = UIImage.placeholderImage()
        }
    }
    
    func configure(forMovieCredit credit: MovieCredit) {
        titleLabel.text = credit.title
        
        if let releaseYear = credit.releaseDate.toDate()?.year() {
            releaseValueLabel.text = "\(releaseYear)"
        } else {
            releaseValueLabel.text = "unknownReleaseText".localized
        }
        
        header.image = UIImage.placeholderImage()
    }
    
    func configureWithState(inFavorites: Bool, inWatchList: Bool) {
        favouriteControl.setSelectedState(inFavorites)
        watchListControl.setSelectedState(inWatchList)
    }
    
    func configure(forDirector director: CrewMember?) {
        directorValueLabel.text = director?.name ?? "unknownDirectorText".localized
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
