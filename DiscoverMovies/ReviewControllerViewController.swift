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
    
    private let reviewManager = TMDbReviewManager()
    private let dataProvider = ReviewDataProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataProvider
        
        signUpForUpdateNotification(self.reviewManager)
        signUpForChangeNotification(self.reviewManager)
        signUpErrorNotification(self.reviewManager)
    }
    
    // MARK: - Notifications 
    
    override func updateNotification(notification: NSNotification) {
        super.updateNotification(notification)
    }
    
    override func changeNotification(notification: NSNotification) {
        super.changeNotification(notification)
    }
    
}

class ReviewDataProvider: NSObject, UITableViewDataSource {
    
    private var reviews = [TMDbReview]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func updateWithReviews(reviews: [TMDbReview]) {
        // tableView.reloadData()
    }
    
}