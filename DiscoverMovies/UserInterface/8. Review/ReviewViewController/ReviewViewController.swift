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
    
    private struct Constants {
        static let DefaultRowHeight: CGFloat = 200
    }
    
    // MARK: Properties
    
    private let movie: Movie

    private let reviewDataProvider = ReviewDataProvider()
    
    private let reviewManager: TMDbReviewManager
    
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
        tableView.registerNib(reviewCellNib, forCellReuseIdentifier: ReviewTableViewCell.defaultIdentifier())
        tableView.dataSource = reviewDataProvider
        tableView.estimatedRowHeight = Constants.DefaultRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        title = "Reviews" // NSLocalizedString
        
        reviewManager.failureDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(ReviewViewController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(ReviewViewController.dataDidLoadTopNotification(_:))
        reviewManager.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)

        reviewManager.reloadIfNeeded(false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        reviewManager.removeObserver(self)
    }
    
    // MARK: Notifications
    
    override func dataDidLoadTopNotification(notification: NSNotification) {
        super.dataDidLoadTopNotification(notification)
        updateTableView()
    }
    
    private func updateTableView() {
        reviewDataProvider.updateWithItems(reviewManager.itemsInList())
        tableView.reloadData()
    }
    
    // Note: - What about authorization errors in this screen
    // Probably we should only show them when we are signed in
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if reviewDataProvider.itemCount - 5 == indexPath.row {
            reviewManager.loadMore()
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

}

