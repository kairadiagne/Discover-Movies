//
//  ReviewViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class ReviewViewController: ListViewController {
    
    private let movie: TMDbMovie
    private let reviewManager = TMDbReviewManager()
    private let dataProvider = ReviewDataProvider()
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.loadMoreBlock = ReviewViewController.loadmore(self)
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        
        signUpForUpdateNotification(self.reviewManager)
        signUpForChangeNotification(self.reviewManager)
        signUpErrorNotification(self.reviewManager)
    }
    
    // MARK: - Initialization
    
    init(movie: TMDbMovie) {
        self.movie = movie
        super.init(nibName: "ReviewViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopObservingNotifications()
    }
    
    // MARK: - Notifications 
    
    override func updateNotification(notification: NSNotification) {
        super.updateNotification(notification)
        dataProvider.updateWithReviews(reviewManager.reviews)
        tableView.reloadData()
    }
    
    override func changeNotification(notification: NSNotification) {
        super.changeNotification(notification)
        dataProvider.updateWithReviews(reviewManager.reviews)
        tableView.reloadData()
    }
    
    // MARK: - Fetching
    
    func loadmore() {
        reviewManager.loadMore()
    }
    
}
