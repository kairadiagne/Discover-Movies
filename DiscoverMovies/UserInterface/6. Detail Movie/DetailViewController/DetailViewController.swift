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
    
    private let movieInfoManager: TMDbMovieInfoManager
    
    private var movie: TMDbMovie
    
    private var image: UIImage?
    
    private var trailer: TMDbVideo?
    
    // MARK: Initializers
    
    init(movie: TMDbMovie, image: UIImage? = nil) {
        movieInfoManager = TMDbMovieInfoManager(movieID: movie.movieID)
        self.movie = movie
        self.image = image
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        let movieCellNib = UINib(nibName: MovieCollectionViewCell.nibName(), bundle: nil)
        let personCellNib = UINib(nibName: PersonCollectionViewCell.nibName(), bundle: nil)
        
        detailView.similarMovieCollectionView.registerNib(movieCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultIdentfier())
        detailView.castCollectionView.registerNib(personCellNib, forCellWithReuseIdentifier: PersonCollectionViewCell.defaultIdentfier())
        
        detailView.castCollectionView.showMessage("Cast unavailable") // NSLocalizedString
        detailView.similarMovieCollectionView.showMessage("No Movies similar to this movie") // NSLocalizedString
        
        // Request information
        movieInfoManager.delegate = self
        movieInfoManager.loadInfo()
        movieInfoManager.loadAccountState()
        
        detailView.configure(withMovie: movie, image: image)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsTransparent()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        detailView.animateOnScreen()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
    // MARK: Actions
    
    @IBAction func favoriteButtonDidGetTapped(sender: FavouriteButton) {
       movieInfoManager.toggleStatusOfMovieInList(.Favorites, status: sender.selected)
    }
    
    @IBAction func watchListDidGetTapped(sender: WatchListButton) {
       movieInfoManager.toggleStatusOfMovieInList(.Watchlist, status: sender.selected)
    }

    @IBAction func reviewsButtonGotTapped(sender: UIButton) {
        showReviews(movie)
    }
    
    @IBAction func playButtonTapped(sender: UIButton) {
        showTrailer()
    }

    // MARK: Navigation
    
    private func showDetail(forMovie movie: TMDbMovie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    private func showTrailer() {
        guard let trailer = trailer else { return } // Display alert that trailer is unavailable
        let videoController = VideoViewController(video: trailer)
        navigationController?.pushViewController(videoController, animated: true)
    }
    
    private func showReviews(movie: TMDbMovie) {
        let reviewViewController = ReviewViewController(movie: movie)
        navigationController?.pushViewController(reviewViewController, animated: true)
    }

}

// MARK: - TMDbMovieInfoManagerDelegate

extension DetailViewController: TMDbMovieInfoManagerDelegate {
    
    func movieInfomManagerDidLoadInfoForMovieWithID(movieID: Int, info: TMDbMovieInfo) {
        // hide message in collection view
        similarMoviesDataProvider.updateWithMovies(info.similarMovies())
        castDataProvider.updateWithCast(info.cast())
        detailView.reloadCollectionViews()
        
        if let director = info.director() {
           detailView.configure(withDirector: director)
        }
        
        trailer = info.trailer()
    }
    
    func movieInfoManagerDidLoadAccoutnStateForMovieWithID(movieID: Int, inFavorites: Bool, inWatchList: Bool) {
        detailView.configureWithState(inFavorites, inWatchList: inWatchList)
    }
    
    func movieInfoManagerDidReceiverError(error: TMDbAPIError) {
       handleError(error)
    }
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let movie = similarMoviesDataProvider.movieAtIndex(indexPath.row) else { return }
        showDetail(forMovie: movie)
    }
    
}
