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

    private(set) var movie: MovieRepresentable
    
    private let similarMoviesDataSource = MovieCollectionDataSource(emptyMessage: "noSimilarMoviesText".localized)

    private let castDataSource = CastDataSource(emptyMessage: "noCastmembersText".localized)

    private let movieDetailManager: MovieDetailManager
    
    private let similarMoviesManager: SimilarMoviesDataManager

    private let signedIn: Bool

    private var observation: NSObjectProtocol?

    // MARK: - Initialize
    
    init(movie: MovieRepresentable, signedIn: Bool) {
        self.movieDetailManager = MovieDetailManager(movieID: movie.identifier)
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

        detailView.configure(forSignIn: signedIn)
        updateUI()

        observation = NotificationCenter.default.addObserver(forName: DataManagerUpdateEvent.dataManagerUpdateNotificationName, object: movieDetailManager, queue: .main) { [weak self] notification in
            self?.dataManagerDidUpdate(notification: notification)
        }
    }

    override func dataManagerDidUpdate(notification: Notification) {
        guard let update = notification.userInfo?[DataManagerUpdateEvent.updateNotificationKey] as? DataManagerUpdateEvent else {
            return
        }

        switch update {
        case .didUpdate:
            guard let movieDetails = movieDetailManager.movieInfo else { return }

            movie = movieDetails.movie
            detailView.configure(forDirector: movieDetails.director)
            detailView.configureWithState(inFavorites: true, inWatchList: movieDetailManager.accountState?.watchlistStatus ?? false)
            updateUI()

            self.castDataSource.items = movieDetails.cast
            self.detailView.castCollectionView.reloadData()
        case .didFailWithError(let error):
            return
//            ErrorHandler.shared.handle(error: .generic, authorizationError: signedIn)
            //           similarMoviesDataSource.items = similarMoviesManager.firstPage
            //        //            detailView.similarMovieCollectionView.reloadData(
            //                    detailView.seeAllButton.isHidden = similarMoviesDataSource.isEmpty
        case .didStartLoading:
            break
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true

        similarMoviesManager.reloadIfNeeded()
        movieDetailManager.reloadIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let movie = movie as? Movie else { return }
        view.window?.windowScene?.userActivity = NSUserActivity.detailActivity(for: movie)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
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

    // MARK: - Actions
    
    @IBAction func favoriteButtontap(_ sender: FavouriteButton) {
       movieDetailManager.toggleStatusOfMovieInList(.favorite, status: sender.isSelected)
    }
    
    @IBAction func watchListButtonTap(_ sender: WatchListButton) {
       movieDetailManager.toggleStatusOfMovieInList(.watchlist, status: sender.isSelected)
    }

    @IBAction func reviewsButtonTap(_ sender: UIButton) {
        let reviewViewController = ReviewViewController(movie: movie, signedIn: signedIn)
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    @IBAction func playButtonTap(_ sender: UIButton) {
        guard let trailer = movieDetailManager.movieInfo?.trailer else { return }
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

// MARK: - VideoViewControllerDelegate

extension MovieDetailViewController: VideoViewControllerDelegate {
    
    func videoViewControllerDidFinish(_ controller: VideoViewController) {
        dismiss(animated: true, completion: nil)
    }
}
