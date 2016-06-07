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

// Can we choose a different navigation controler delegate
// Use navigation controller delegate to see when the animation of showing the view controller has ended
// When push view controller is not animated updateconstraints and layoutsubviews are being caled after or in viewdidAppear

class DetailView: BackgroundView {
    
    // MARK: Properties
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    @IBOutlet weak var contentView: BackgroundView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
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
    
    @IBOutlet weak var imageHeader: GradientImageView!
    
    @IBOutlet weak var favouriteControl: FavouriteButton!
    
    @IBOutlet weak var watchListControl: WatchListButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var topImageHeaderConstraint: NSLayoutConstraint!
   
    // MARK: Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Fonts Labels
        self.titleLabel.font = UIFont.H1()
        self.overviewLabel.font = UIFont.Body()
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
        
        // Color of buttons 
        self.favouriteControl.lineColor = UIColor.buttonColor()
        self.favouriteControl.fillColor = UIColor.buttonColor()
        self.watchListControl.lineColor = UIColor.buttonColor()
        self.watchListControl.fillColor = UIColor.buttonColor()
        
        self.readReviewsButton.tintColor = UIColor.buttonColor()
        self.readReviewsButton.layer.borderWidth = 1.5
        self.readReviewsButton.layer.borderColor = UIColor.buttonColor().CGColor
        
        // Scrollview 
        self.detailScrollView.delegate = self
        
        // Prepare for animation 
        self.imageHeader.alpha = 0.2
        self.playButton.alpha = 0.0
    }
    
    // MARK: Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    // MARK: UICollectionView
    
    func registerCollectionViewCells(castIdentifier: String, movieIdentifier: String) {
        let movieCellNib = UINib(nibName: MovieCollectionViewCell.defaultIdentiier(), bundle: nil)
        let personCellNib = UINib(nibName: PersonCollectionViewCell.defaultIdentiier(), bundle: nil)
        castCollectionView.registerNib(personCellNib, forCellWithReuseIdentifier: castIdentifier)
        similarMovieCollectionView.registerNib(movieCellNib, forCellWithReuseIdentifier: movieIdentifier)
    }
    
    func registerCollectionViewDataSources(castSource: UICollectionViewDataSource, similarMoviesSource: UICollectionViewDataSource) {
        castCollectionView.dataSource = castSource
        similarMovieCollectionView.dataSource = similarMoviesSource
    }
    
    func registerCollectionViewDelegate(delegate: UICollectionViewDelegate) {
        similarMovieCollectionView.delegate = delegate
    }
    
    func reloadCollectionViews() {
        castCollectionView.reloadData()
        similarMovieCollectionView.reloadData()
    }
    
    // MARK: Configure
    
    func configure(movie: TMDbMovie, image: UIImage? = nil) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview ?? "N/A"
        genreValueLabel.text = movie.genres.first?.name ?? "Unknown"
        ratingValueLabel.text = "\(movie.rating!)\\10.0" // Round
        releaseValueLabel.text = movie.releaseDate != nil ? "\(movie.releaseDate!.year())" : "Unknown"
        
        if let image = image {
            imageHeader.image = image
        } else if let path = movie.backDropPath, url = TMDbImageRouter.BackDropMedium(path: path).url {
            imageHeader.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
        }
    }
    
    func configureWithCredit(credit: TMDbMovieCredit) {
        directorValueLabel.text = credit.director?.name ?? "Unknown"
    }
    
    func configureForAccountState(state: TMDbAccountState) {
        favouriteControl.selected = state.favoriteStatus
        watchListControl.selected = state.watchlistStatus
    }
    
    // MARK: Animation
    
    private var didAnimate = false
    
    func animateOnScreen() {
        // Lookup how to animate constraints on apple developers website.
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseInOut], animations: { 
            self.imageHeader.alpha = 1.0
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseInOut], animations: {
            self.playButton.alpha = 1.0
        }, completion: nil)
    }

}

// MARK: UIScrollViewDelegate

extension DetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Do some kind of calculation for size of header view and stretchy parelax scrolling effetc.
    }

}
