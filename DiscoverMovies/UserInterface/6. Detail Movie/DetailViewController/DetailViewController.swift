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
    
    fileprivate let similarMoviesDataSource = SimilarMovieDataSource()
    
    fileprivate let castDataSource = CastDataSource()
  
    fileprivate let movieInfoManager: TMDbMovieInfoManager
    
    fileprivate let movie: Movie
    
    fileprivate var videoController: VideoViewController?
    
    fileprivate var didAnimate = false
    
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
        
        if !didAnimate {
            didAnimate = true
            detailView.animatePresentation()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteButtontap(_ sender: FavouriteButton) {
       movieInfoManager.toggleStatusOfMovieInList(.favorite, status: sender.isSelected)
    }
    
    @IBAction func watchListButtonTap(_ sender: WatchListButton) {
       movieInfoManager.toggleStatusOfMovieInList(.watchlist, status: sender.isSelected)
    }

    @IBAction func reviewsButtonTap(_ sender: UIButton) {
        showReviews(movie)
    }
    
    @IBAction func playButtonTap(_ sender: UIButton) {
        showTrailer()
    }

    // MARK: - Navigation
    
    fileprivate func showDetail(forMovie movie: Movie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
    fileprivate func showTrailer() {
        guard let videoController = videoController else { return }
        present(videoController, animated: true, completion: nil)
    }
    
    fileprivate func showReviews(_ movie: Movie) {
        let reviewViewController = ReviewViewController(movie: movie)
        navigationController?.pushViewController(reviewViewController, animated: true)
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
        detailView.configure(withDirector: info.director)
        
        if let trailer = info.trailer {
            videoController = VideoViewController(video: trailer)
        }
        
        similarMoviesDataSource.update(withItems: info.similarMovies)
        castDataSource.update(withItems: info.cast)
        
        detailView.similarMovieCollectionView.reloadData()
        detailView.castCollectionView.reloadData()
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, movieWithID: Int, inFavorites: Bool, inWatchList: Bool) {
        detailView.configureWithState(inFavorites, inWatchList: inWatchList)
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didFailWithErorr error: APIError) {
        ErrorHandler.shared.handle(error: error, isAuthorized: signedIn)
    }
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = similarMoviesDataSource.item(atIndex: indexPath.row) else { return }
        showDetail(forMovie: movie)
    }
    
}
