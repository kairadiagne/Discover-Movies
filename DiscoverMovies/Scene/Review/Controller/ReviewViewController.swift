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
    
    // MARK: Constants
    
    private struct Constants {
        static let ReviewCellIdentifier = "ReviewCell"
        static let DefaultRowHeight: CGFloat = 200
    }
    
    // MARK: Properties
    
    private let movie: TMDbMovie
    
    private let reviewManager = TMDbReviewManager()
    
    private let reviewDataProvider = ReviewDataProvider()
    
    private var reviewListener: TMDbDataManagerListener<TMDbReviewManager>!
    
    // MARK: Initializers
    
    init(movie: TMDbMovie) {
        self.movie = movie
        super.init(nibName: "ListViewController", bundle: nil)
        self.reviewListener = TMDbDataManagerListener(delegate: self, manager: reviewManager)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        reviewDataProvider.cellIdentifier = Constants.ReviewCellIdentifier
        
        let reviewCellNib = UINib(nibName: ReviewTableViewCell.defaultIdentifier(), bundle: nil)
        tableView.registerNib(reviewCellNib, forCellReuseIdentifier: Constants.ReviewCellIdentifier)
        tableView.dataSource = reviewDataProvider
        tableView.estimatedRowHeight = Constants.DefaultRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reviewManager.loadReviews(movie.movieID)
    }
    
    // MARK: Fetching
    
    func loadmore() {
        reviewManager.loadMore()
    }
    
    // MARK: Notifications
    
    override func dataManagerDataDidUpdateNotification(notification: NSNotification) {
        super.dataManagerDataDidUpdateNotification(notification)
        updateData()
    }
    
    override func dataManagerDataDidChangeNotification(notification: NSNotification) {
        super.dataManagerDataDidChangeNotification(notification)
        updateData()
    }
    
    private func updateData() {
        reviewDataProvider.updateWithReviews(reviewManager.reviews)
        tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if reviewDataProvider.reviewCount - 5 == indexPath.row {
            loadmore()
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

}

