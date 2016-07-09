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
    @IBOutlet var castDataProvider: CastDataProvider!
    @IBOutlet var similarMoviesDataProvider: SimilarMovieDataProvider!

    private let movie: TMDbMovie
    private var image: UIImage?
    private let movieInfoManager = TMDbMovieInfoManager()

    // MARK: Initializers
    
    init(movie: TMDbMovie, image: UIImage? = nil) {
        self.movie = movie
        self.image = image
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
        
        detailView.castCollectionView.showMessage("Cast unavailable") // NSLocalizedString
        detailView.similarMovieCollectionView.showMessage("No Movies similar to this movie") // NSLocalizedString
        
        detailView.configure(withMovie: movie, image: image)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsTransparent()
        
        movieInfoManager.addChangeObserver(self, selector: #selector(DetailViewController.dataDidChangeNotification(_:)))
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
       movieInfoManager.toggleStateOfMovieInList(movie.movieID, list: .Favorites)
    }
    
    @IBAction func watchListDidGetTapped(sender: WatchListButton) {
       movieInfoManager.toggleStateOfMovieInList(movie.movieID, list: .Watchlist)
    }

    @IBAction func reviewsButtonGotTapped(sender: UIButton) {
        showReviews(movie)
    }
    
    @IBAction func playButtonTapped(sender: UIButton) {
        showTrailer()
    }
    
    // MARK: Notifications
    
    override func dataDidChangeNotification(notification: NSNotification) {
        super.dataDidChangeNotification(notification)
        
        switch movieInfoManager.state {
        case .Loading:
            showProgressHUD()
        case .DataDidLoad:
            update()
        case .Error:
            handleErrorState(movieInfoManager.lastError, authorizationRequired: signedIn )
        default:
            return
        }
    }
    
    private func update() {
        if let similarMovies = movieInfoManager.similarMovies {
            detailView.similarMovieCollectionView.hideMessage()
            similarMoviesDataProvider.updateWithMovies(similarMovies)
            detailView.reloadCollectionViews()
        }
        
        if let cast = movieInfoManager.cast {
            detailView.castCollectionView.hideMessage()
            castDataProvider.updateWithCast(cast)
            detailView.reloadCollectionViews()
        }
        
        detailView.configure(withDirector: movieInfoManager.director, withAccountState: movieInfoManager.accountState)
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