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
    private let reviewDataProvider = ReviewDataProvider()
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        reviewDataProvider.cellIdentifier = "ReviewCell"
        tableView.dataSource = reviewDataProvider
        tableView.delegate = self
        
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
        reviewDataProvider.updateWithReviews(reviewManager.reviews)
        tableView.reloadData()
    }
    
    override func changeNotification(notification: NSNotification) {
        super.changeNotification(notification)
        reviewDataProvider.updateWithReviews(reviewManager.reviews)
        tableView.reloadData()
    }
    
    // MARK: - Fetching
    
    func loadmore() {
        reviewManager.loadMore()
    }
    
}

// MARK: - UITableViewDelegate

extension ReviewViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if reviewDataProvider.reviewCount - 5 == indexPath.row {
            loadmore()
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
}
