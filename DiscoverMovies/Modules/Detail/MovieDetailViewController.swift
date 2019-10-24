//
//  DetailViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//
//
import UIKit
import TMDbMovieKit

final class MovieDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var detailView: MovieDetailView!
    
    private let similarMoviesDataSource = MovieCollectionDataSource(emptyMessage: "noSimilarMoviesText".localized)

    private let castDataSource = CastDataSource(emptyMessage: "noCastmembersText".localized)
  
    private let movieInfoManager: MovieDetailManager
    
    private let similarMoviesManager: SimilarMoviesDataManager
    
    private var movie: MovieRepresentable
    
    private let signedIn: Bool
    
    private var trailer: Video?
    
    // MARK: - Initialize
    
    init(movie: MovieRepresentable, signedIn: Bool) {
        self.movieInfoManager = MovieDetailManager(movieID: movie.identifier)
        self.similarMoviesManager = SimilarMoviesDataManager(movieID: movie.identifier)
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
        
        detailView.similarMovieCollectionView.register(PosterImageCollectionViewCell.nib, forCellWithReuseIdentifier: PosterImageCollectionViewCell.reuseId)
        detailView.similarMovieCollectionView.register(NoDataCollectionViewCell.nib, forCellWithReuseIdentifier: NoDataCollectionViewCell.reuseId)
        detailView.castCollectionView.register(PosterImageCollectionViewCell.nib, forCellWithReuseIdentifier: PosterImageCollectionViewCell.reuseId)
        detailView.castCollectionView.register(NoDataCollectionViewCell.nib, forCellWithReuseIdentifier: NoDataCollectionViewCell.reuseId)
        
        detailView.castCollectionView.dataSource = castDataSource
        detailView.castCollectionView.delegate = self
        
        detailView.similarMovieCollectionView.dataSource = similarMoviesDataSource
        detailView.similarMovieCollectionView.delegate = self
        
        detailView.scrollView.delegate = self
        
        movieInfoManager.delegate = self
        
        movieInfoManager.loadAdditionalInfo()
        movieInfoManager.loadAccountState()
        
        detailView.configure(forSignIn: signedIn)
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let loadingSelector = #selector(MovieDetailViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(MovieDetailViewController.dataManagerDidUpdate(notification:))
//        similarMoviesManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)

        // Moe simulr moies and casts etc into a child view controller. 
        similarMoviesManager.reloadIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let movie = movie as? Movie else { return }
        view.window?.windowScene?.userActivity = movie.openMovieDetailUseractivity
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
        similarMoviesManager.remove(observer: self)

        view.window?.windowScene?.userActivity = nil
    }
    
    // MARK: - Update UI
    
    private func updateUI() {
        if let movie = movie as? Movie {
            detailView.configure(forMovie: movie)
        } else if let movieCredit = movie as? MovieCredit {
            detailView.configure(forMovieCredit: movieCredit)
        }
    }

    // MARK: - Notifications
    
    override func dataManagerDidUpdate(notification: Notification) {
        similarMoviesDataSource.items = similarMoviesManager.firstPage
        detailView.similarMovieCollectionView.reloadData()
        detailView.seeAllButton.isHidden = similarMoviesDataSource.isEmpty
    }
    
    // MARK: - DataManagerFailureDelegate
    
//    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
//        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
//        detailView.similarMovieCollectionView.reloadData()
//        detailView.castCollectionView.reloadData()
//    }

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
        guard let trailer = trailer else { return }
        let videoViewController = VideoViewController(video: trailer)
        videoViewController.delegate = self
        let navigationController = BaseNavigationController(rootViewController: videoViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTap(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func seeAllButtonClick(_ sender: UIButton) {
        let title = "similarMoviesVCTitle".localized
        let similarMovieListController = GenericTableViewController(dataManager: similarMoviesManager, titleString: title, signedIn: signedIn)
        navigationController?.pushViewController(similarMovieListController, animated: true)
    }
}

// MARK: - UISCrollViewDelegate

extension MovieDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailView.moveHeaderOnScroll()
    }
}

// MARK: - UICollectionViewDelegate

extension MovieDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == detailView.similarMovieCollectionView {
            guard let movie = similarMoviesDataSource.item(atIndex: indexPath.row) else { return }
            showDetailViewController(for: movie, signedIn: signedIn)
        } else if collectionView == detailView.castCollectionView {
            guard let person = castDataSource.item(atIndex: indexPath.row) else { return }
            let personDetailViewController = PersonDetailViewController(person: person, signedIn: signedIn)
            navigationController?.pushViewController(personDetailViewController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    
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

// MARK: - MovieDetailManagerDelegate

extension MovieDetailViewController: MovieDetailManagerDelegate {
    
    func movieInfoManager(_ manager: MovieDetailManager, didLoadInfo info: MovieInfo, forMovieWIthID id: Int) {
        movie = info.movie
        trailer = info.trailer
        
        detailView.configure(forDirector: info.director)
        updateUI()
        
        castDataSource.items = info.cast
        detailView.castCollectionView.reloadData()
    }
    
    func movieInfoManager(_ manager: MovieDetailManager, movieWithID: Int, inFavorites: Bool, inWatchList: Bool) {
        detailView.configureWithState(inFavorites, inWatchList: inWatchList)
    }
    
    func movieInfoManager(_ manager: MovieDetailManager, didFailWithErorr error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }
}

// MARK: - VideoViewControllerDelegate

extension MovieDetailViewController: VideoViewControllerDelegate {
    
    func videoViewControllerDidFinish(_ controller: VideoViewController) {
        dismiss(animated: true, completion: nil)
    }
}
