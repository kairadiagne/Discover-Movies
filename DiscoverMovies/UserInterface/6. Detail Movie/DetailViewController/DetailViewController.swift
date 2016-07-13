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

    private let movieInfoManager: TMDbMovieInfoManager!
    private var image: UIImage?
    
    // MARK: Initializers
    
    init(movie: TMDbMovie, image: UIImage? = nil) {
        self.movieInfoManager = TMDbMovieInfoManager(withMovie: movie)
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
        
        detailView.configure(withMovie: movieInfoManager.movie, image: image)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsTransparent()
        movieInfoManager.addChangeObserver(self, selector: #selector(DetailViewController.dataDidChangeNotification(_:)))
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
       movieInfoManager.toggleStatusOfMovieInList(.Favorites, status: sender.selected)
    }
    
    @IBAction func watchListDidGetTapped(sender: WatchListButton) {
       movieInfoManager.toggleStatusOfMovieInList(.Watchlist, status: sender.selected)
    }

    @IBAction func reviewsButtonGotTapped(sender: UIButton) {
        showReviews(movieInfoManager.movie)
    }
    
    @IBAction func playButtonTapped(sender: UIButton) {
        showTrailer()
    }
    
    // MARK: Notifications
    
    override func dataDidChangeNotification(notification: NSNotification) {
        super.dataDidChangeNotification(notification)
        
        switch movieInfoManager.state {
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
        let director = movieInfoManager.director
        let inFavorites = movieInfoManager.inFavorites
        let inWatchList = movieInfoManager.inWatchList
        detailView.configure(withDirector: director, inFavorites: inFavorites, inWatchList: inWatchList)
    }

    // MARK: Navigation
    
    private func showDetail(forMovie movie: TMDbMovie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    private func showTrailer() {
        guard let video = movieInfoManager.trailers?.first else { return }
        let videoController = VideoViewController(video: video)
        navigationController?.pushViewController(videoController, animated: true)
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
        showDetail(forMovie: movie)
    }
    
}
