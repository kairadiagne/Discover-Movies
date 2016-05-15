//
//  DetailViewController\.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class DetailViewController: UIViewController {
    
    var detailView: DetailView { return view as! DetailView }
    
    var movie: TMDbMovie
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
        // Set navigation bar to transparent
        navigationController?.navigationBar.setAsTransparent()
        // Turn automatic adjustment of scrollViewInsets to navigation bar off
        automaticallyAdjustsScrollViewInsets = false
        
        // Set up colelction view dataproviders 
        detailView.castCollectionView.delegate = castDataProvider
        detailView.castCollectionView.dataSource = castDataProvider
        detailView.similarMoviesCollectionView.delegate = similarMoviesDataProvider
        detailView.similarMoviesCollectionView.dataSource = similarMoviesDataProvider
        similarMoviesDataProvider.didSelectBlock = DetailViewController.showDetailSimilarMovie(self)
        
        // Sign up for notifications 
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let updateSelector = #selector(DetailViewController.update(_:))
        notificationCenter.addObserver(self, selector: updateSelector, name: TMDbManagerDataDidUpdateNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Fetch aditional info about the movie
        if let movieID = movie.movieID {
            movieInfoManager.reloadIfNeeded(true, movieID: movieID)
        }
        
        // Configure Detail View
        detailView.configureForMovie(movie, image: image)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // Reset navigationbar
        navigationController?.navigationBar.setAsUnclear()
    }
    
    // MARK: - Notifications 
    
    func update(notification: NSNotification) {
        similarMoviesDataProvider.updateWithMovies(movieInfoManager.similarMovies)
        
        guard let movieCredit = movieInfoManager.movieCredit else { return }
        castDataProvider.updateWithMovieCredit(movieCredit: movieCredit)
        detailView.configureWithMovieCredit(movieCredit)
    }

    // MARK: - Navigation
    
    private func showDetailSimilarMovie(movie: TMDbMovie) {
        let detailViewControlelr = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewControlelr, animated: true)
    }
    
    private func showTrailer(movie: TMDbMovie) {
//        let videoViewController = VideoViewController(video: )
//        navigationController?.pushViewController(VideoViewController, animated: true)
    }
    
    private func showReviews(movie: TMDbMovie) {
//        let reviewControlelr = ReviewController(movie: Movie)
//        navigationController?.pushViewController(reviewViewController, animated: true)
        
    }

}



