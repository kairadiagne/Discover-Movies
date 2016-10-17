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
        let noDataCellNib = UINib(nibName: NoDataCollectionViewCell.nibName(), bundle: nil)
        detailView.similarMovieCollectionView.register(movieCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.defaultIdentfier())
        detailView.similarMovieCollectionView.register(noDataCellNib, forCellWithReuseIdentifier: NoDataCollectionViewCell.defaultIdentfier())
        detailView.castCollectionView.register(personCellNib, forCellWithReuseIdentifier: PersonCollectionViewCell.defaultIdentfier())
        detailView.castCollectionView.register(noDataCellNib, forCellWithReuseIdentifier: NoDataCollectionViewCell.defaultIdentfier())
        
        detailView.castCollectionView.dataSource = castDataSource
        detailView.similarMovieCollectionView.dataSource = similarMoviesDataSource
     
        detailView.scrollView.delegate = self
        
        movieInfoManager.delegate = self
        movieInfoManager.loadInfo()
        movieInfoManager.loadAccountState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        detailView.configure(withMovie: movie, signedIn: signedIn)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
        navigationController?.delegate = nil
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteButtontap(_ sender: FavouriteButton) {
       movieInfoManager.toggleStatusOfMovieInList(.favorite, status: sender.isSelected)
    }
    
    @IBAction func watchListButtonTap(_ sender: WatchListButton) {
       movieInfoManager.toggleStatusOfMovieInList(.watchlist, status: sender.isSelected)
    }

    @IBAction func reviewsButtonTap(_ sender: UIButton) {
        let reviewViewController = ReviewViewController(movie: movie)
        navigationController?.pushViewController(reviewViewController, animated: true)
    }
    
    @IBAction func playButtonTap(_ sender: UIButton) {
        guard let videoController = videoController else { return }
        present(videoController, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTap(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
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
        let detailViewController = DetailViewController(movie: movie)
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
        
        similarMoviesDataSource.update(withItems: info.similarMovies)
        castDataSource.update(withItems: info.cast)
        
        detailView.similarMovieCollectionView.reloadData()
        detailView.castCollectionView.reloadData()
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, movieWithID: Int, inFavorites: Bool, inWatchList: Bool) {
        detailView.configureWithState(inFavorites, inWatchList: inWatchList)
    }
    
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didFailWithErorr error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }
    
}

extension DetailViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return toVC is DetailViewController ? DetailAnimatedTransitioning() : nil
    }
    
}
