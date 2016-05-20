//
//  ReviewDataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

// TODO: - Show Background Message. How??

class ReviewDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var reviews = [TMDbReview]()
    
    var cellIdentifier = ""
    
    var reviewCount: Int {
        return reviews.count
    }
    
    func reviewForIndex(index: Int) -> TMDbReview? {
        guard index >= 0 && index <= reviewCount else { return nil }
        return reviews[index]
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ReviewTableViewCell
        let review = reviews[indexPath.row]
        cell.configure(review)
        return cell
    }
    
    func updateWithReviews(reviews: [TMDbReview]) {
        self.reviews = reviews
    }
    
}