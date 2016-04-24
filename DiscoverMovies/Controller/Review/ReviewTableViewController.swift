//
//  ReviewTableViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class ReviewTableViewController: DiscoverBaseTableViewController {
    
    private struct Constants {
        static let ReviewCellReuseIdentifier = "ReviewTableViewCell"
    }
    
    private let reviewCoordinator = ReviewCoordinator()
    
    var movie: TMDbMovie? {
        didSet {
            self.reviewCoordinator.delegate = self
            guard let movieID = movie?.movieID else { return }
            reviewCoordinator.fetchReviews(movieID)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        setupBackground(withMessage: "There are no reviews for this movie")
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewCoordinator.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.ReviewCellReuseIdentifier) as! ReviewTableViewCell
        let review = reviewCoordinator.items[indexPath.row]
        cell.configure(review)
        return cell
    }
        
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        reviewCoordinator.fetchNextPageIfNeeded(indexPath.row)
    }
        
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
 
}

