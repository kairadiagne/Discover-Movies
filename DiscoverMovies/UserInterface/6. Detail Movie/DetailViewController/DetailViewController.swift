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
    
    @IBOutlet weak var detailView: DetailView!
    @IBOutlet var castDataProvider: CastDataProvider!
    @IBOutlet var similarMoviesDataprovider: SimilarMovieDataProvider!
    
    fileprivate let movieInfoManager: TMDbMovieInfoManager
    
    fileprivate var movie: Movie
    
    fileprivate var image: UIImage?
    
    fileprivate var trailer: Video?
    
    // MARK: Initialize
    
    init(movie: Movie, image: UIImage? = nil) {
        movieInfoManager = TMDbMovieInfoManager(movieID: movie.id)
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
        detailView.similarMovieCollectionView.register(movieCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultIdentfier())
        detailView.castCollectionView.register(personCellNib, forCellWithReuseIdentifier: PersonCollectionViewCell.defaultIdentfier())
        
        detailView.castCollectionView.showMessage("Cast unavailable") // NSLocalizedString
        detailView.similarMovieCollectionView.showMessage("No Movies similar to this movie") // NSLocalizedString
        
        movieInfoManager.delegate = self
        movieInfoManager.loadInfo()
        movieInfoManager.loadAccountState()
        
        detailView.configure(withMovie: movie, image: image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsTransparent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        detailView.animateOnScreen()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
    // MARK: Actions
    
    @IBAction func favoriteButtonDidGetTapped(_ sender: FavouriteButton) {
       movieInfoManager.toggleStatusOfMovieInList(.favorite, status: sender.isSelected)
    }
    
    @IBAction func watchListDidGetTapped(_ sender: WatchListButton) {
       movieInfoManager.toggleStatusOfMovieInList(.watchlist, status: sender.isSelected)
    }

    @IBAction func reviewsButtonGotTapped(_ sender: UIButton) {
        showReviews(movie)
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        showTrailer()
    }

    // MARK: Navigation
    
    fileprivate func showDetail(forMovie movie: Movie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    fileprivate func showTrailer() {
        guard let trailer = trailer else { return } // Display alert that trailer is unavailable
        let videoController = VideoViewController(video: trailer)
        navigationController?.pushViewController(videoController, animated: true)
    }
    
    fileprivate func showReviews(_ movie: Movie) {
        let reviewViewController = ReviewViewController(movie: movie)
        navigationController?.pushViewController(reviewViewController, animated: true)
    }

}

// MARK: - TMDbMovieInfoManagerDelegate

extension DetailViewController: TMDbMovieInfoManagerDelegate {
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didLoadInfo info: MovieInfo, forMovieWIthID id: Int) {
        // hide message in collection view
        similarMoviesDataprovider.updateWithMovies(info.similarMovies())
        castDataProvider.updateWithCast(info.cast())
        detailView.reloadCollectionViews()
        
        if let director = info.director() {
            detailView.configure(withDirector: director)
        }
        
        trailer = info.trailer()
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didFailWithErorr error: APIError) {
        // handleError(error)
    }
    
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, movieWithID: Int, inFavorites: Bool, inWatchList: Bool) {
        detailView.configureWithState(inFavorites, inWatchList: inWatchList)
    }
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = similarMoviesDataprovider.movieAtIndex(indexPath.row) else { return }
        showDetail(forMovie: movie)
    }
    
}
