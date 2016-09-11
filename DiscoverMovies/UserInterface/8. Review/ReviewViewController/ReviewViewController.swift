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
    
    // MARK: Types
    
    fileprivate struct Constants {
        static let DefaultRowHeight: CGFloat = 200
    }
    
    // MARK: Properties
    
    fileprivate let movie: Movie

    fileprivate let reviewDataProvider = ReviewDataProvider()
    
    fileprivate let reviewManager: TMDbReviewManager
    
    // MARK: Initialize
    
    init(movie: Movie) {
        self.movie = movie
        self.reviewManager = TMDbReviewManager(movieID: movie.id)
        super.init(nibName: "ListViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reviewCellNib = UINib(nibName: ReviewTableViewCell.nibName(), bundle: nil)
        tableView.register(reviewCellNib, forCellReuseIdentifier: ReviewTableViewCell.defaultIdentifier())
        tableView.dataSource = reviewDataProvider
        tableView.estimatedRowHeight = Constants.DefaultRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        title = "Reviews" // NSLocalizedString
        
        reviewManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(ReviewViewController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(ReviewViewController.dataDidLoadTopNotification(_:))
        reviewManager.add(observer: self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)

        reviewManager.reloadIfNeeded(forceOnline: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reviewManager.remove(observer: self)
    }
    
    // MARK: Notifications
    
    override func dataDidLoadTopNotification(_ notification: Notification) {
        super.dataDidLoadTopNotification(notification)
        updateTableView()
    }
    
    fileprivate func updateTableView() {
        reviewDataProvider.updateWithItems(reviewManager.itemsInList())
        tableView.reloadData()
    }
    
    // Note: - What about authorization errors in this screen
    // Probably we should only show them when we are signed in
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if reviewDataProvider.itemCount - 5 == (indexPath as NSIndexPath).row {
            reviewManager.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: IndexPath) -> Bool {
        return false
    }

}

