//
//  DetailViewController\.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class DetailViewController: BaseViewController {
    
    // MARK: Properties
    
    @IBOutlet var detailView: DetailView!

    private let movie: TMDbMovie
    
    private var image: UIImage?
    
    private let movieInfoManager = TMDbMovieInfoManager()
    
    private let castDataProvider: CastDataProvider
    
    private let similarMoviesDataProvider: SimilarMovieDataProvider
    
    // MARK: Initializers
    
    init(movie: TMDbMovie, image: UIImage? = nil) {
        self.movie = movie
        self.image = image
        self.castDataProvider = CastDataProvider(cellIdentifier: PersonCollectionViewCell.defaultIdentfier())
        self.similarMoviesDataProvider = SimilarMovieDataProvider(cellIdentifier: MovieCollectionViewCell.defaultIdentfier())
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        let movieCellNib = UINib(nibName: MovieCollectionViewCell.nibName(), bundle: nil)
        let personCellNib = UINib(nibName: PersonCollectionViewCell.nibName(), bundle: nil)
        detailView.similarMovieCollectionView.registerNib(movieCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultIdentfier())
        detailView.castCollectionView.registerNib(personCellNib, forCellWithReuseIdentifier: PersonCollectionViewCell.defaultIdentfier())
        
        detailView.registerDataSources(castDataProvider, similar: similarMoviesDataProvider)
        detailView.registerCollectionViewDelegate(self)
        
        detailView.delegate = self
        detailView.configure(movie, image: image)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsTransparent()
        
        movieInfoManager.addUpdateObserver(self, selector: #selector(DetailViewController.dataDidUpdateNotification(_:)))
        movieInfoManager.addErrorObserver(self, selector: #selector(DetailViewController.didReceiveErrorNotification(_:)))
        
        movieInfoManager.loadInfoAboutMovieWithID(movie.movieID)
        movieInfoManager.loadAccountStateForMovieWithID(movie.movieID)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        detailView.animateOnScreen()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setAsUnclear()
        
        movieInfoManager.removeObserver(self)
    }
    
    // MARK: Actions
    
    @IBAction func favoriteButtonDidGetTapped(sender: FavouriteButton) {
       movieInfoManager.toggleStateOfMovieInList(sender.selected, movieID: movie.movieID, list: .Favorites)
    }
    
    @IBAction func watchListDidGetTapped(sender: WatchListButton) {
       movieInfoManager.toggleStateOfMovieInList(sender.selected, movieID: movie.movieID, list: .Watchlist)
    }

    @IBAction func reviewsButtonGotTapped(sender: UIButton) {
        showReviews(movie)
    }
    
    // MARK: Notifications
    
    override func dataDidUpdateNotification(notification: NSNotification) {
        super.dataDidUpdateNotification(notification)
        
        if let similarMovies = movieInfoManager.similarMovies {
            similarMoviesDataProvider.updateWithMovies(similarMovies)
        } else {
            // Show message in collection view: Similar movies
        }
        
        if let accountState = movieInfoManager.accountState {
            detailView.configureForAccountState(accountState)
            detailView.reloadCollectionViews()
        }
        
        if let movieCredit = movieInfoManager.movieCredit {
            castDataProvider.updateWithMovieCredit(movieCredit)
            detailView.configureWithCredit(movieCredit)
            detailView.reloadCollectionViews()
        }
        
    }
    
    override func didReceiveErrorNotification(notification: NSNotification) {
       super.didReceiveErrorNotification(notification)
        // Handle authorization error
    }

    // MARK: Navigation
    
    private func showDetailSimilarMovie(movie: TMDbMovie) {
        let detailViewControlelr = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewControlelr, animated: false)
    }
    
    private func showTrailer() {
        guard let video = movieInfoManager.trailers?.first else { return }
        let videoController = VideoViewController(video: video)
        navigationController?.pushViewController(videoController, animated: true )
    }
    
    private func showReviews(movie: TMDbMovie) {
        let reviewViewController = ReviewViewController(movie: movie)
        navigationController?.pushViewController(reviewViewController, animated: true)
    }

}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let movie = similarMoviesDataProvider.movieAtIndex(indexPath.row) else { return }
        showDetailSimilarMovie(movie)
    }
    
}

// MARK: - DetailViewDelegate

extension DetailViewController: DetailViewDelegate {
    
    func detailViewDelegateDidTapTrailerButton() {
        showTrailer()
    }

}
