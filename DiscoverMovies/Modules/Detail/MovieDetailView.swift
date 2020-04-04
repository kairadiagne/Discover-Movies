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
    
    // MARK: Properties
    
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
    @IBOutlet weak var headerImageView: GradientImageView!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var headerTop: NSLayoutConstraint!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var animationConstraint: NSLayoutConstraint!
    
    private var contentInsetTop: CGFloat = 0
    private var defaultHeaderheight: CGFloat = 0
    private var didSetContentInset = false
    
    // MARK: Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerImageView.colors = [UIColor.clear, UIColor.systemBackground]
        
        favouriteControl.lineColor = .buttonColor()
        favouriteControl.fillColor = .buttonColor()
        watchListControl.lineColor = .buttonColor()
        watchListControl.fillColor = .buttonColor()
        
        directorLabel.text = "directorLabelText".localized
        genreLabel.text = "genreLabelText".localized
        releaseLabel.text = "releaseLabelText".localized
        ratingLabel.text =  "ratingLabelText".localized
        
        seeAllButton.setTitle("seeAllButtonText".localized, for: .normal)
        seeAllButton.setTitleColor(.white, for: .normal)
        seeAllButton.isHidden = true
        
        // For animation
        headerImageView.alpha = 0.3
        playButton.alpha = 0.3
    }
    
    // MARK: Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !didSetContentInset {
            didSetContentInset = true
            defaultHeaderheight = headerHeightConstraint.constant
            contentInsetTop = headerHeightConstraint.constant - safeAreaInsets.top
            scrollView.contentInset.top = contentInsetTop
        }
    }
    
    // MARK: Configure
    
    func configure(forSignIn signedIn: Bool) {
        favouriteControl.isHidden = !signedIn
        watchListControl.isHidden = !signedIn
    }
    
    func configure(forMovie movie: Movie) {
        if let imageURL = TMDbImageRouter.backDropMedium(path: movie.backdropPath).url {
            headerImageView.sd_setImage(with: imageURL, placeholderImage: UIImage.placeholderImage())
        } else {
            headerImageView.image = UIImage.placeholderImage()
        }
        
        titleLabel.text = movie.title
        descriptionLabel.text = !movie.overview.isEmpty ? movie.overview : "noDescriptionText".localized
        directorValueLabel.text = movie.director?.name ?? "unknownDirectorText".localized
        //        genreValueLabel.text = movie.genres.first?.name ?? "unknownGenreText".localized
        ratingValueLabel.text =  "\(movie.rating)\\10.0"
        
        if let releaseYear = movie.releaseDate.toDate()?.year() {
            releaseValueLabel.text = "\(releaseYear)"
        } else {
            releaseValueLabel.text = "unknownReleaseText".localized
        }
    }
    
    func configureWithState(inFavorites: Bool, inWatchList: Bool) {
        favouriteControl.setSelectedState(inFavorites)
        watchListControl.setSelectedState(inWatchList)
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
