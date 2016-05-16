//
//  ReviewDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit 

class ReviewDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private struct Constants {
        static let ReviewCellIdentifier = "ReviewCell"
    }
    
    private var reviews = [TMDbReview]()
    
    var loadMoreBlock: (() -> ())?
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reviews.count == 0 {
//            tableView.showMessage
        }
        return reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.ReviewCellIdentifier, forIndexPath: indexPath) as! ReviewTableViewCell
        let review = reviews[indexPath.row]
        cell.configure(review)
        return cell
    }
    
    func updateWithReviews(reviews: [TMDbReview]) {
        self.reviews = reviews
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if reviews.count - 5 == indexPath.row {
            loadMoreBlock?()
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
}