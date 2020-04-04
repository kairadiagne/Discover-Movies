//
//  DetailViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//
//
import UIKit
import CoreData
import TMDbMovieKit

final class MovieDetailViewController: UIViewController {
    
    // MARK: View Properties
    
    @IBOutlet weak var detailView: MovieDetailView!
    
    // MARK: Properties
    
    private let signedIn: Bool
    
    private let movieDataProvider: MovieDetailDataProvider
    
    // MARK: Initialize
    
    init(movieObjectID: NSManagedObjectID, signedIn: Bool) {
        self.movieDataProvider = MovieDetailDataProvider(managedObjectID: movieObjectID)
        self.signedIn = signedIn
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.scrollView.delegate = self

        detailView.configure(forSignIn: signedIn)
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        movieDataProvider.fetchAdditionalDetails { [weak self] in
            guard let self = self else { return }
            self.updateUI()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
        view.window?.windowScene?.userActivity = nil
    }
    
    // MARK: - Update UI
    
    private func updateUI() {
        guard let movie = movieDataProvider.movie else {
            return
        }
        
        detailView.configure(forMovie: movie)
    }

    // MARK: - Actions
    
    @IBAction func favoriteButtontap(_ sender: FavouriteButton) {
    }
    
    @IBAction func watchListButtonTap(_ sender: WatchListButton) {
    }

    @IBAction func reviewsButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func playButtonTap(_ sender: UIButton) {
    }
    
    @IBAction func seeAllButtonClick(_ sender: UIButton) {
        let title = "similarMoviesVCTitle".localized
//        let similarMovieListController = MovieListViewController(dataManager: similarMoviesManager, titleString: title, signedIn: signedIn)
//        navigationController?.pushViewController(similarMovieListController, animated: true)
    }
}

// MARK: - UISCrollViewDelegate

extension MovieDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailView.moveHeaderOnScroll()
    }
}

// MARK: - VideoViewControllerDelegate

extension MovieDetailViewController: VideoViewControllerDelegate {
    
    func videoViewControllerDidFinish(_ controller: VideoViewController) {
        dismiss(animated: true, completion: nil)
    }
}

//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
////        guard let movie = movie as? Movie else { return }
////        view.window?.windowScene?.userActivity = NSUserActivity.detailActivity(for: movie)
//    }


extension MovieDetailViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push && toVC == self {
            return DetailAnimatedTransitioning()
        } else {
            return CrossDissolveAnimatedTransitioning()
        }
    }
}
