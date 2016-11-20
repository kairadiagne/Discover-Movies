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
    
    fileprivate let similarMoviesManager: TMDbSimilarMoviesDataManager
    
    fileprivate let movie: Movie
    
    fileprivate var videoController: VideoViewController?
    
    fileprivate let signedIn: Bool
    
    // MARK: - Initialize
    
    init(movie: Movie, signedIn: Bool) {
        self.movieInfoManager = TMDbMovieInfoManager(movieID: movie.id)
        self.similarMoviesManager = TMDbSimilarMoviesDataManager(movieID: movie.id)
        self.movie = movie
        self.signedIn = signedIn
        super.init(nibName: nil, bundle: nil)
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
        let noDataCellNib = UINib(nibName: NoDataCollectionViewCell.nibName(), bundle: nil)
        detailView.similarMovieCollectionView.register(movieCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultIdentfier())
        detailView.similarMovieCollectionView.register(noDataCellNib, forCellWithReuseIdentifier: NoDataCollectionViewCell.defaultIdentfier())
        detailView.castCollectionView.register(personCellNib, forCellWithReuseIdentifier: PersonCollectionViewCell.defaultIdentfier())
        detailView.castCollectionView.register(noDataCellNib, forCellWithReuseIdentifier: NoDataCollectionViewCell.defaultIdentfier())
        
        detailView.castCollectionView.dataSource = castDataSource
        detailView.castCollectionView.delegate = self
        
        detailView.similarMovieCollectionView.dataSource = similarMoviesDataSource
        detailView.similarMovieCollectionView.delegate = self
     
        detailView.scrollView.delegate = self
        
        movieInfoManager.delegate = self
        similarMoviesManager.failureDelegate = self
        
        movieInfoManager.loadInfo()
        movieInfoManager.loadAccountState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        similarMoviesManager.reloadIfNeeded()
        
        let loadingSelector = #selector(TopListViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(TopListViewController.dataManagerDidUpdate(notification:))
        
        similarMoviesManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        navigationController?.navigationBar.isHidden = true
        
        automaticallyAdjustsScrollViewInsets = false
        
        detailView.configure(withMovie: movie, signedIn: signedIn)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
        navigationController?.delegate = nil
        
        similarMoviesManager.remove(observer: self)
    }
    
    // MARK: - Notifications
    
    override func dataManagerDidUpdate(notification: Notification) {
        similarMoviesDataSource.items = similarMoviesManager.firstPage
        detailView.similarMovieCollectionView.reloadData()
    }
    
    // MARK: - DataManagerFailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }

    // MARK: - Actions
    
    @IBAction func favoriteButtontap(_ sender: FavouriteButton) {
       movieInfoManager.toggleStatusOfMovieInList(.favorite, status: sender.isSelected)
    }
    
    @IBAction func watchListButtonTap(_ sender: WatchListButton) {
       movieInfoManager.toggleStatusOfMovieInList(.watchlist, status: sender.isSelected)
    }

    @IBAction func reviewsButtonTap(_ sender: UIButton) {
        let reviewViewController = ReviewViewController(movie: movie, signedIn: signedIn)
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    @IBAction func playButtonTap(_ sender: UIButton) {
        guard let videoController = videoController else { return }
        present(videoController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTap(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seeAllButtonClick(_ sender: UIButton) {
        let title = NSLocalizedString("similarMoviesVCTitle", comment: "")
        let similarMovieListController = GenericViewController(dataManager: similarMoviesManager, titleString: title, signedIn: signedIn)
        navigationController?.pushViewController(similarMovieListController, animated: true)
    }

}

// MARK: - UISCrollViewDelegate

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailView.moveHeaderOnScroll()
    }
    
}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = similarMoviesDataSource.item(atIndex: indexPath.row) else { return }
        let detailViewController = DetailViewController(movie: movie, signedIn: signedIn)
        navigationController?.delegate = detailViewController
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    // Size of the specified item's cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === detailView.similarMovieCollectionView {
            return !similarMoviesDataSource.isEmpty ? CGSize(width: 78, height: 130): detailView.similarMovieCollectionView.bounds.size
        } else {
            return !castDataSource.isEmpty ? CGSize(width: 78, height: 130): detailView.castCollectionView.bounds.size
        }
    }
    
    // Margins to apply to content in the specified section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    // spacing between successive rows or columns of a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // Spacing between successive items in the rows or columns of a section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

// MARK: - TMDbMovieInfoManagerDelegate

extension DetailViewController: TMDbMovieInfoManagerDelegate {
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didLoadInfo info: MovieInfo, forMovieWIthID id: Int) {
        detailView.configure(withDirector: info.director)
        
        if let trailer = info.trailer {
            videoController = VideoViewController(video: trailer)
        }
        
        castDataSource.items = info.cast
        detailView.castCollectionView.reloadData()
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, movieWithID: Int, inFavorites: Bool, inWatchList: Bool) {
        detailView.configureWithState(inFavorites, inWatchList: inWatchList)
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didFailWithErorr error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }
    
}

// MARK: - UINavigationControllerDelegate 

extension DetailViewController: UINavigationControllerDelegate { 
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return toVC is DetailViewController ? DetailAnimatedTransitioning() : nil
    }
    
}
