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
    
    private struct Constants {
        static let MovieCellIdentifier = "MovieCell"
        static let MovieCellNibName = "MovieCollectionViewCell"
        static let PersonCellIdentifier = "PersonCell"
        static let PersonCellNibName = "PersonCollectionViewCell"
    }
    
    var detailView: DetailView { return view as! DetailView }
    
    let movie: TMDbMovie
    var image: UIImage?
    var imageURL: NSURL?
    
    private let movieInfoManager = TMDbMovieInfoManager()
    private let castDataProvider = CastDataProvider()
    private let similarMoviesDataProvider = SimilarMovieDataProvider()

    // MARK: - Initialization 
    
    required init(movie: TMDbMovie, image: UIImage? = nil, imageURL url: NSURL? = nil) {
        self.movie = movie
        self.image = image
        self.imageURL = url
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setAsTransparent()
        automaticallyAdjustsScrollViewInsets = false
       
        castDataProvider.cellIdentifier = Constants.PersonCellIdentifier
        detailView.castCollectionView.dataSource = castDataProvider
        
        similarMoviesDataProvider.cellIdentifier = Constants.MovieCellIdentifier
        detailView.similarMoviesCollectionView.dataSource = similarMoviesDataProvider
        detailView.similarMoviesCollectionView.delegate = self
        
        let movieCellNib = UINib(nibName: Constants.MovieCellNibName, bundle: nil)
        let personCellNib = UINib(nibName: Constants.PersonCellNibName, bundle: nil)
        detailView.castCollectionView.registerNib(personCellNib, forCellWithReuseIdentifier: Constants.PersonCellIdentifier)
        detailView.similarMoviesCollectionView.registerNib(movieCellNib, forCellWithReuseIdentifier: Constants.MovieCellIdentifier)
        
        let updateSelector = #selector(DetailViewController.update(_:))
        let errorSelector = #selector(DetailViewController.handleError(_:))
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: updateSelector, name: TMDbManagerDataDidUpdateNotification, object: nil)
        notificationCenter.addObserver(self, selector: errorSelector, name: TMDbManagerDidReceiveErrorNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        detailView.configureForMovie(movie, image: image)
        
        if let movieID = movie.movieID {
            movieInfoManager.reloadIfNeeded(true, movieID: movieID)
        }

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.setAsUnclear()
    }
    
    // MARK: - Actions 
    
    @IBAction func favouriteButtonGotTapped(sender: FavouriteButton) {
        // Add or remove movie from favourites
    }
    
    // MARK: - Notifications 
    
    func update(notification: NSNotification) {
        similarMoviesDataProvider.updateWithMovies(movieInfoManager.similarMovies)
        
        if let movieCredit = movieInfoManager.movieCredit { // Ugly sollution
            if castDataProvider.count == 0 {
                castDataProvider.updateWithMovieCredit(movieCredit: movieCredit)
                detailView.configureWithMovieCredit(movieCredit)
            }
        }
    }
    
    func handleError(notification: NSNotification) {
        // Extract and check the error
    }

    // MARK: - Navigation
    
    private func showDetailSimilarMovie(movie: TMDbMovie) {
        let detailViewControlelr = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewControlelr, animated: true)
    }
    
    private func showTrailer(movie: TMDbMovie) {
//        let videoViewController = VideoViewController(video: )
//        navigationController?.pshViewController(VideoViewController, animated: true)
    }
    
    private func showReviews(movie: TMDbMovie) {
        let reviewViewController = ReviewViewController(movie: movie)
        navigationController?.pushViewController(reviewViewController, animated: true)
        
    }

}

// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == detailView.similarMoviesCollectionView{
            guard let movie = similarMoviesDataProvider.movieAtIndex(indexPath.row) else { return }
            showDetailSimilarMovie(movie)
        }
    }
}



