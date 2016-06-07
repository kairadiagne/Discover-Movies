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
    
    // MARK: Constants
    
    private struct Constants {
        static let MovieCellIdentifier = "MovieCell"
        static let PersonCellIdentifier = "PersonCell"
    }
    
    // MARK: Properties
    
    @IBOutlet var detailView: DetailView!

    let movie: TMDbMovie
    
    var image: UIImage?
    
    private let movieInfoManager = TMDbMovieInfoManager()
    
    private let castDataProvider = CastDataProvider()
    
    private let similarMoviesDataProvider = SimilarMovieDataProvider()
    
    private var movieInfoListener: TMDbDataManagerListener<TMDbMovieInfoManager>!

    // MARK: Initializers
    
    required init(movie: TMDbMovie, image: UIImage? = nil) {
        self.movie = movie
        self.image = image
        super.init(nibName: "DetailViewController", bundle: nil)
        self.movieInfoListener = TMDbDataManagerListener(delegate: self, manager: movieInfoManager)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        detailView.registerCollectionViewCells(Constants.PersonCellIdentifier, movieIdentifier: Constants.MovieCellIdentifier)
        detailView.registerCollectionViewDataSources(castDataProvider, similarMoviesSource: similarMoviesDataProvider)
        castDataProvider.cellIdentifier = Constants.PersonCellIdentifier
        similarMoviesDataProvider.cellIdentifier = Constants.MovieCellIdentifier
        detailView.registerCollectionViewDelegate(self)
        
        detailView.delegate = self
        
        detailView.configure(movie, image: image)
        print("DidLoad: \(view.bounds)")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsTransparent()
        
        movieInfoManager.loadInfoAboutMovieWithID(movie.movieID)
        movieInfoManager.loadAccountStateForMovieWithID(movie.movieID)
        
        detailView.prepareForOnScreenAnimation()
        print("WillAppear: \(view.bounds)")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        detailView.animateOnScreen() // Animate only the first time the screen is loaded 
        print("DidAppear: \(view.bounds)")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setAsUnclear()
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
    
    override func dataManagerDataDidUpdateNotification(notification: NSNotification) {
        super.dataManagerDataDidUpdateNotification(notification)
        
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
    
    override func dataManagerDidReceiveErrorNotification(error: NSError?) {
        super.dataManagerDidReceiveErrorNotification(error)
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
        if collectionView == detailView.similarMoviesCollectionView{
            if let movie = similarMoviesDataProvider.movieAtIndex(indexPath.row) {
                showDetailSimilarMovie(movie)
            }
        }
    }
}

// MARK: - DetailViewDelegate

extension DetailViewController: DetailHeaderViewDelegate {
    
    func detailHeaderViewDelegateDidTapPlayButton() {
        showTrailer()
    }
}



