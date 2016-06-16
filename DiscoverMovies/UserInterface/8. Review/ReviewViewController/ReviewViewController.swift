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
    
    // MARK: Initializers
    
    init(movie: TMDbMovie) {
        self.movie = movie
        super.init(nibName: "ListViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reviewCellNib = UINib(nibName: ReviewTableViewCell.nibName(), bundle: nil)
        tableView.registerNib(reviewCellNib, forCellReuseIdentifier: ReviewTableViewCell.defaultIdentifier())
        tableView.dataSource = reviewDataProvider
        tableView.estimatedRowHeight = Constants.DefaultRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reviewManager.addChangeObserver(self, selector: #selector(ReviewViewController.dataDidChangeNotification(_:)))
        reviewManager.addUpdateObserver(self, selector: #selector(ReviewViewController.dataDidUpdateNotification(_:)))
        reviewManager.addErrorObserver(self, selector: #selector(ReviewViewController.didReceiveErrorNotification(_:)))
        
        reviewManager.loadReviews(movie.movieID)
    }
    
    override func viewWillDisappear(animated: Bool) {
        reviewManager.removeObserver(self)
    }
    
    // MARK: Fetching
    
    func loadmore() {
        reviewManager.loadMore()
    }
    
    // MARK: Notifications
    
    override func dataDidUpdateNotification(notification: NSNotification) {
        super.dataDidUpdateNotification(notification)
        updateData()
    }
    
    override func dataDidChangeNotification(notification: NSNotification) {
        super.dataDidChangeNotification(notification)
        updateData()
    }
    
    private func updateData() {
        reviewDataProvider.updateWithItems(reviewManager.reviews)
        tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if reviewDataProvider.itemCount - 5 == indexPath.row {
            loadmore()
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

}

