//
//  DetailViewController\.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//
//
import UIKit
import TMDbMovieKit

class DetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var detailView: DetailView!
    
    fileprivate var similarMoviesDataSource = SimilarMovieDataSource()
    
    fileprivate var castDataSource = CastDataSource()
  
    fileprivate let movieInfoManager: TMDbMovieInfoManager
    
    fileprivate var movie: Movie
    
    fileprivate var trailer: Video?
    
    fileprivate var firstLaunch: Bool = true
    
    // MARK: - Initialize
    
    init(movie: Movie) {
        movieInfoManager = TMDbMovieInfoManager(movieID: movie.id)
        self.movie = movie
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        let movieCellNib = UINib(nibName: MovieCollectionViewCell.nibName(), bundle: nil)
        let personCellNib = UINib(nibName: PersonCollectionViewCell.nibName(), bundle: nil)
        detailView.similarMovieCollectionView.register(movieCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultIdentfier())
        detailView.castCollectionView.register(personCellNib, forCellWithReuseIdentifier: PersonCollectionViewCell.defaultIdentfier())
        
        detailView.castCollectionView.dataSource = castDataSource
        detailView.similarMovieCollectionView.dataSource = similarMoviesDataSource
     
        detailView.scrollView.delegate = self
        
        movieInfoManager.delegate = self
        movieInfoManager.loadInfo()
        movieInfoManager.loadAccountState()
        
        detailView.configure(withMovie: movie)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setAsTransparent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstLaunch {
            firstLaunch = false
            detailView.animateOnScreen()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteButtonDidGetTapped(_ sender: FavouriteButton) { //FavoriteButtonTap
       movieInfoManager.toggleStatusOfMovieInList(.favorite, status: sender.isSelected)
    }
    
    @IBAction func watchListDidGetTapped(_ sender: WatchListButton) { // WatchListButtonTap
       movieInfoManager.toggleStatusOfMovieInList(.watchlist, status: sender.isSelected)
    }

    @IBAction func reviewsButtonGotTapped(_ sender: UIButton) { // reviewButtonTap
        showReviews(movie)
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) { // playButtonTap
        showTrailer()
    }

    // MARK: - Navigation
    
    fileprivate func showDetail(forMovie movie: Movie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    fileprivate func showTrailer() {
        guard let trailer = trailer else { return } // Display alert that trailer is unavailable 
//        let videoController = VideoViewController(video: trailer)
//        navigationController?.pushViewController(videoController, animated: true)
    }
    
    fileprivate func showReviews(_ movie: Movie) {
//        let reviewViewController = ReviewViewController(movie: movie)
//        navigationController?.pushViewController(reviewViewController, animated: true)
    }

}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailView.moveHeaderOnScroll()
    }
    
}

// MARK: - TMDbMovieInfoManagerDelegate

extension DetailViewController: TMDbMovieInfoManagerDelegate {
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didLoadInfo info: MovieInfo, forMovieWIthID id: Int) {
        similarMoviesDataSource.update(withItems: info.similarMovies)
        castDataSource.update(withItems: info.cast)
        
        detailView.similarMovieCollectionView.reloadData()
        detailView.castCollectionView.reloadData()
        
        detailView.configure(withDirector: info.director)
        
        trailer = info.trailer
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, movieWithID: Int, inFavorites: Bool, inWatchList: Bool) {
        detailView.configureWithState(inFavorites, inWatchList: inWatchList)
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didFailWithErorr error: APIError) {
    }
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = similarMoviesDataSource.item(atIndex: indexPath.row) else { return }
        showDetail(forMovie: movie)
    }
    
}
