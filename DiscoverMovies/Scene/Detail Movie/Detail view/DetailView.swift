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

@objc protocol DetailHeaderViewDelegate {
    func detailHeaderViewDelegateDidTapPlayButton()
}

class DetailView: BackgroundView {
    
    // MARK: Constants
    
    private struct Constants {
        static let HeaderHeight: CGFloat = 291
        static let PlayButtonSize = CGSize(width: 50, height: 50)
        static let FillViewSize = CGSize(width: 30, height: 30)
    }
    
    // MARK: Properties
    
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var castLabel: UILabel!
    
    @IBOutlet weak var similarMoviesLabel: UILabel!
    
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
    
    @IBOutlet weak var readReviewsButton: UIButton!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    var headerImageView: GradientImageView!
    
    var playButton = UIButton()
    
    var fillView = UIView()
    
    weak var delegate: DetailHeaderViewDelegate?
   
    // MARK: Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFontsForLabels()
        setUpButtons()
        setupCollectionView()
        setupHeaderView()
        setupScrollView()
        updateHeaderView()
        setUpPlayButton()
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
        self.favouriteButton.lineColor = UIColor.buttonColor()
        self.favouriteButton.fillColor = UIColor.buttonColor()
        self.watchListButton.lineColor = UIColor.buttonColor()
        self.watchListButton.fillColor = UIColor.buttonColor()
        
        self.readReviewsButton.tintColor = UIColor.buttonColor()
        self.readReviewsButton.layer.borderWidth = 1.5
        self.readReviewsButton.layer.borderColor = UIColor.buttonColor().CGColor
    }
    
    private func setupCollectionView() {
        self.similarMoviesCollectionView.collectionViewLayout = DetailFlowLayout()
        self.castCollectionView.collectionViewLayout = DetailFlowLayout()       
    }
    
    private func setupScrollView() {
        self.detailScrollView.delegate = self
        self.detailScrollView.contentInset = UIEdgeInsets(top: Constants.HeaderHeight, left: 0, bottom: 0, right: 0)
        self.detailScrollView.contentOffset = CGPoint(x: 0, y: -Constants.HeaderHeight)
    }
    
    private func setupHeaderView() {
        let colors = [UIColor.backgroundColor().CGColor, UIColor.clearColor().CGColor]
        let startPoint = CGPoint(x: 0, y: 1)
        let endPoint = CGPoint(x: 0, y: 0.1)
        self.headerImageView = GradientImageView(colors: colors, startPoint: startPoint, endPoint: endPoint, frame: CGRect.zero)
        self.headerImageView.contentMode = .ScaleAspectFill
        self.detailScrollView.addSubview(headerImageView)
    }
    
    private func setUpPlayButton() {
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.playButton.setImage(UIImage.playIcon(), forState: .Normal)
        self.playButton.tintColor = UIColor.backgroundColor()
        let playSelector = #selector(DetailView.detailButtonPressed)
        self.playButton.addTarget(self, action: playSelector, forControlEvents: .TouchUpInside)
        
        self.fillView.translatesAutoresizingMaskIntoConstraints = false
        self.fillView.backgroundColor = UIColor.whiteColor()
        
        self.detailScrollView.addSubview(self.fillView)
        self.detailScrollView.addSubview(self.playButton)
            
        self.fillView.centerXAnchor.constraintEqualToAnchor(self.headerImageView.centerXAnchor).active = true
        self.fillView.centerYAnchor.constraintEqualToAnchor(self.headerImageView.centerYAnchor).active = true
        self.fillView.heightAnchor.constraintEqualToConstant(Constants.FillViewSize.height).active = true
        self.fillView.widthAnchor.constraintEqualToConstant(Constants.FillViewSize.width).active = true
            
        self.playButton.centerXAnchor.constraintEqualToAnchor(self.headerImageView.centerXAnchor).active = true
        self.playButton.centerYAnchor.constraintEqualToAnchor(self.headerImageView.centerYAnchor).active = true
        self.playButton.heightAnchor.constraintEqualToConstant(Constants.PlayButtonSize.height).active = true
        self.playButton.widthAnchor.constraintEqualToConstant(Constants.PlayButtonSize.width).active = true
    }
    
    // MARK: UICollectionView
    
    func registerCollectionViewDataSources(castSource: UICollectionViewDataSource, similarMoviesSource: UICollectionViewDataSource) {
        castCollectionView.dataSource = castSource
        similarMoviesCollectionView.dataSource = similarMoviesSource
    }
    
    func registerCollectionViewDelegate(delegate: UICollectionViewDelegate) {
        similarMoviesCollectionView.delegate = delegate
    }
    
    func registerCollectionViewCells(castIdentifier: String, movieIdentifier: String) {
        let movieCellNib = UINib(nibName: MovieCollectionViewCell.defaultIdentiier(), bundle: nil)
        let personCellNib = UINib(nibName: PersonCollectionViewCell.defaultIdentiier(), bundle: nil)
        castCollectionView.registerNib(personCellNib, forCellWithReuseIdentifier: castIdentifier)
        similarMoviesCollectionView.registerNib(movieCellNib, forCellWithReuseIdentifier: movieIdentifier)
    }
    
    func reloadCollectionViews() {
        castCollectionView.reloadData()
        similarMoviesCollectionView.reloadData()
    }
    
    // MARK: Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame.size.width = self.bounds.width
    }
    
    // MARK: Header

    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -Constants.HeaderHeight, width: detailScrollView.bounds.width, height: Constants.HeaderHeight)
        
        // Header grows when the Y ofsset of the scroll view is greater then the headerheight
        if detailScrollView.contentOffset.y < -Constants.HeaderHeight {
            headerRect.origin.y = detailScrollView.contentOffset.y
            headerRect.size.height = -detailScrollView.contentOffset.y
        }
    
        headerImageView.frame = headerRect
    }
    
    // MARK: Configure
    
    func configure(movie: TMDbMovie, image: UIImage? = nil) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview ?? "N/A"
        genreValueLabel.text = movie.genres.first?.name ?? "Unknown"
        ratingValueLabel.text = "\(movie.rating!)\\10.0" // Round
        releaseValueLabel.text = movie.releaseDate != nil ? "\(movie.releaseDate!.year())" : "Unknown"
        
        if let image = image {
            headerImageView.image = image
        } else if let path = movie.backDropPath, url = TMDbImageRouter.BackDropMedium(path: path).url {
            headerImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
        }
    }
    
    func configureWithCredit(credit: TMDbMovieCredit) {
        directorValueLabel.text = credit.director?.name ?? "Unknown"
    }
    
    func configureForAccountState(state: TMDbAccountState) {
        favouriteButton.setAsSelected(state.favoriteStatus)
        watchListButton.setAsSelected(state.watchlistStatus)
    }
    
    // MARK: Actions
    
    func detailButtonPressed() {
        delegate?.detailHeaderViewDelegateDidTapPlayButton()
    }
    
    // MARK: Animation
    
    func prepareForOnScreenAnimation() {
        if detailScrollView.contentOffset.y == -Constants.HeaderHeight {
            headerImageView.alpha = 0.5
            topConstraint.constant += bounds.height / 4
            layoutIfNeeded()
        }
        
    }
    
    func animateOnScreen() {
        if detailScrollView.contentOffset.y == -Constants.HeaderHeight {
            UIView.animateWithDuration(0.4, delay: 0.0, options: [.CurveEaseInOut], animations: {
                self.topConstraint.constant -= self.bounds.height / 4
                self.layoutIfNeeded()
                }, completion: nil)
            
            UIView.animateWithDuration(0.8, delay: 0.3, options: [.CurveEaseInOut], animations: {
                self.headerImageView.alpha = 1.0
                }, completion: nil)
            
        }
        
    }

}

// MARK: UIScrollViewDelegate

extension DetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

}
