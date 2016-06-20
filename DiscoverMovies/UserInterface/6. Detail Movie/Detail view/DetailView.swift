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

protocol DetailViewDelegate: class {
    func detailViewDelegateDidTapTrailerButton()
}

class DetailView: BackgroundView, UIScrollViewDelegate {
    
    // MARK: - Types 
    
    private struct Constants {
        static let ImageHeaderHeight: CGFloat = 290
    }
    
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
    
    @IBOutlet weak var castCollectionView: BaseCollectionView!
    
    @IBOutlet weak var similarLabel: UILabel!
    
    @IBOutlet weak var similarMovieCollectionView: BaseCollectionView!
    
    @IBOutlet weak var readReviewsButton: UIButton!
    
    @IBOutlet weak var favouriteControl: FavouriteButton!
    
    @IBOutlet weak var watchListControl: WatchListButton!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var animatedConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollTopConstraint: NSLayoutConstraint!
    
    var imageHeader: GradientImageView!
    
    var playButton: UIButton!
    
    weak var delegate: DetailViewDelegate?
    
    var didAnimate = false
    
    // Later change this (naming, and calculate with percetages (relative))
    
    var defaultOffset: CGFloat {
        return Constants.ImageHeaderHeight - scrollTopConstraint.constant
    }
    
    // imageheaderheight (relative so use percentage)
    

    // MARK: Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        
        self.favouriteControl.lineColor = UIColor.buttonColor()
        self.favouriteControl.fillColor = UIColor.buttonColor()
        self.watchListControl.lineColor = UIColor.buttonColor()
        self.watchListControl.fillColor = UIColor.buttonColor()
    
        self.readReviewsButton.tintColor = UIColor.buttonColor()
        self.readReviewsButton.layer.borderWidth = 1.5
        self.readReviewsButton.layer.borderColor = UIColor.buttonColor().CGColor
        
        let colors = [UIColor.backgroundColor().CGColor, UIColor.clearColor().CGColor]
        let startPoint = CGPoint(x: 0, y: 1)
        let endPoint = CGPoint(x: 0, y: 0.1)
        
        self.imageHeader = GradientImageView(colors: colors, startPoint: startPoint, endPoint: endPoint, frame: .zero)
        self.imageHeader.contentMode = .ScaleAspectFill
        self.imageHeader.userInteractionEnabled = false
        self.addSubview(self.imageHeader)
        
        self.playButton = UIButton()
        self.playButton.setImage(UIImage.playIcon(), forState: .Normal)
        let selector = #selector(DetailView.playButtonTapped(_:))
        self.playButton.addTarget(delegate, action: selector, forControlEvents: .TouchUpInside)
        self.addSubview(self.playButton)

        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        self.playButton.centerXAnchor.constraintEqualToAnchor(self.imageHeader.centerXAnchor).active = true
        self.playButton.centerYAnchor.constraintEqualToAnchor(self.imageHeader.centerYAnchor).active = true
        self.playButton.widthAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.13).active = true
        self.playButton.heightAnchor.constraintEqualToAnchor(self.contentView.widthAnchor, multiplier: 0.13).active = true
        
        self.detailScrollView.delegate = self
        
        self.imageHeader.alpha = 0.3
        self.playButton.alpha = 0.0
    }
    
    // MARK: Life Cyle

    override func layoutSubviews() {
        super.layoutSubviews()
        updateHeaderImageFrame()
    }

    // MARK: UIScrollViewDelegate

    func scrollViewDidScroll(scrollView: UIScrollView) {
        var frame = CGRect(x: imageHeader.frame.origin.x, y: imageHeader.frame.origin.y, width: imageHeader.frame.size.width, height: imageHeader.frame.size.height)
        frame.size.height += -detailScrollView.contentOffset.y
        self.imageHeader.frame = frame
    }
    
    // MARK: HeaderImageView
    
    private func updateHeaderImageFrame() {
        // Set the height of the header
        self.imageHeader.frame = CGRect(x: 0, y: 0, width: bounds.width, height: Constants.ImageHeaderHeight)
        
        self.detailScrollView.contentInset = UIEdgeInsets(top: defaultOffset, left: 0, bottom: 0, right: 0)
        
        
        
        
        
//        let imageframe = CGRect(x: 0, y: 0, width: self.bounds.width, height: imageHeaderHeight)
//        print("HeaderFrame: \(imageHeader.frame)")
//        var imageHeaderFrame = CGRect(x: 0, y: Constants.ImageHeaderHeight, width: detailScrollView.bounds.width, height: -Constants.ImageHeaderHeight)
        
//        print("OffSet: \(detailScrollView.contentOffset)")
//        print("Inset: \(detailScrollView.contentInset)")
//        
//        let calculation = detailScrollView.contentOffset.y - detailScrollView.contentInset.top
        
//        if calculation < 0 {
//            imageHeader.frame.size.height = detailScrollView.contentOffset.y * -1 // Convert to postive valeu find cleaner sollution
//            detailScrollView.contentInset.top = -detailScrollView.contentOffset.y
//        } else if calculation == 0 {
            // Image header should be standard height (Default)
            // Inset is height
//        } else if calculation > 0 {
            // Image header should be smaller
            // Inset should be header height
//        } else if calculation >= 44 {
            // image header should be 44
            // Inste should be 44
//        }
        
//        imageHeader.frame = imageframe
    
//        if detailScrollView.contentOffset.y < Constants.ImageHeaderHeight {
////            detailScrollView.contentInset.top = detailScrollView.contentOffset.y
//        }
//        
//        
//        
//        
//        if detailScrollView.contentOffset.y >= -Constants.ImageHeaderYCuttOff {
////            detailScrollView.contentInset = UIEdgeInsets(top: Constants.MinImageHaderHeight, left: 0 , bottom: 0, right: 0)
////            imageHeaderFrame.origin.y = -Constants.ImageHeaderYCuttOff
////            imageHeaderFrame.size.height = -Constants.MinImageHaderHeight
//        } else if detailScrollView.contentOffset.y < -Constants.ImageHeaderHeight {
////            imageHeaderFrame.origin.y = detailScrollView.contentOffset.y
////            imageHeaderFrame.size.height = -detailScrollView.contentOffset.y
//        }
    
//        imageHeader.frame = imageHeaderFrame
    }
    
    
    
    // MARK: UICollectionView
    
    func registerDataSources(cast: UICollectionViewDataSource ,similar: UICollectionViewDataSource) {
        castCollectionView.dataSource = cast
        similarMovieCollectionView.dataSource = similar
    }
    
    func registerCollectionViewDelegate(delegate: UICollectionViewDelegate) {
        similarMovieCollectionView.delegate = delegate
    }
    
    func reloadCollectionViews() {
        castCollectionView.reloadData()
        similarMovieCollectionView.reloadData()
    }
    
    func configure(movie: TMDbMovie, image: UIImage? = nil) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview ?? "N/A"
        genreValueLabel.text = movie.genres.first?.name ?? "Unknown"
        ratingValueLabel.text = "\(movie.rating!)\\10.0"
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
        favouriteControl.setSelectedState(state.favoriteStatus)
        watchListControl.setSelectedState(state.watchlistStatus)
    }
    
    // MARK: Actions
    
    func playButtonTapped(button: UIButton) {
        delegate?.detailViewDelegateDidTapTrailerButton()
    }
    
    // MARK: Animation
    
    func animateOnScreen() {
        if !didAnimate {
            didAnimate = true
            // Ensure that all pending layout operations have been completed
            self.layoutIfNeeded()
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseInOut], animations: {
                self.topConstraint.priority = 750
                self.animatedConstraint.priority = 250
                self.layoutIfNeeded()
                }, completion: nil)
            
            UIView.animateWithDuration(0.5, delay: 0.3, options: [.CurveEaseInOut], animations: {
                self.imageHeader.alpha = 1.0
                }, completion: nil)
            
            UIView.animateWithDuration(0.2, delay: 0.6, options: [.CurveEaseInOut], animations: {
                self.playButton.alpha = 1.0
                }, completion: nil)
        }
    }
}
