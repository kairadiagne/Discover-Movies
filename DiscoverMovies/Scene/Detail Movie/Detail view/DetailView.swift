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
        self.readReviewsButton.layer.borderWidth = 1.0
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
        self.playButton.setImage(UIImage(named: "play"), forState: .Normal)
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
    
    // MARK: Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImageView.frame.size.width = self.bounds.width
    }
    
    // MARK: Header

    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -Constants.HeaderHeight, width: detailScrollView.bounds.width, height: Constants.HeaderHeight)
        
        // If the y offset of the scrollview is greater than the headerheight the headerheight gets adjusted (grows in height)
        if detailScrollView.contentOffset.y < -Constants.HeaderHeight {
            headerRect.origin.y = detailScrollView.contentOffset.y
            headerRect.size.height = -detailScrollView.contentOffset.y
        }
    
        headerImageView.frame = headerRect
    }
    
    // MARK: Configure
    
    // TODO: - Configure methods need to be more clear (Single method)
  
    func configureForMovie(movie: TMDbMovie, image: UIImage? = nil, url: NSURL? = nil) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview ?? "N/A"
        genreValueLabel.text = movie.genres.first?.name ?? "Unknown"
        ratingValueLabel.text = "\(movie.rating!)\\10.0"
        releaseValueLabel.text = movie.releaseDate != nil ? "\(movie.releaseDate!.year())" : "Unknown"
        setImage(image, url: url)
    }
    
    func configureWithMovieCredit(movieCredit: TMDbMovieCredit) {
        directorValueLabel.text = movieCredit.director?.name ?? "Unknown"
    }
    
    func configureForAccountState(accountState: TMDbAccountState) {
        favouriteButton.setAsSelected(accountState.favoriteStatus)
        watchListButton.setAsSelected(accountState.watchlistStatus)
    }
    
    private func setImage(image: UIImage?, url: NSURL?) {
        if let image = image {
            headerImageView.image = image
        } else if let url = url {
            headerImageView.sd_setImageWithURL(url, placeholderImage: UIImage.placeholderImage())
        }
    }
    
    // MARK: Actions
    
    func detailButtonPressed() {
        delegate?.detailHeaderViewDelegateDidTapPlayButton()
    }
    
    // MARK: Animation

    func prepareForAnimation() { // Naming??
        headerImageView.alpha = 0.2
        topConstraint.constant += bounds.height / 4
        layoutIfNeeded()
    }
    
    func startAnimation() { // Naming??
        
        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseInOut], animations: { 
            self.topConstraint.constant -= self.bounds.height
            
            self.topConstraint.constant -= self.bounds.height / 4
            self.layoutIfNeeded()
            self.headerImageView.alpha = 1.0
            }, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
        
//        UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseInOut], animations: { // Bouncines spring
//            
//            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.CurveEaseInOut], animations: {
           
            }, completion: nil)
        
    }

}

// MARK: UIScrollViewDelegate

extension DetailView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

}
