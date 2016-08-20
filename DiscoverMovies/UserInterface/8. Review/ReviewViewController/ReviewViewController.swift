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
    
    // MARK: Initializers
    
    init(movie: Movie) {
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
        
        title = "Reviews" // NSLocalizedString
        
//        TMDbReviewManager.shared.failureDelegate = self // Is this neccesarry
//        TMDbReviewManager.shared.movieID = movie.movieID
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(ReviewViewController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(ReviewViewController.dataDidLoadTopNotification(_:))
        let didUpdateSelctor = #selector(ReviewViewController.dataDidUpdateNotification(_:))
//        TMDbReviewManager.shared.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector, didUpdateSelector: didUpdateSelctor)
//    
//        TMDbReviewManager.shared.reloadTopIfNeeded(false)
    }
    
    override func viewWillDisappear(animated: Bool) {
//        TMDbReviewManager.shared.removeObserver(self)
    }
    
    // MARK: Notifications
    
    override func dataDidLoadTopNotification(notification: NSNotification) {
        super.dataDidLoadTopNotification(notification)
        updateTableView()
    }
    
    
    override func dataDidUpdateNotification(notification: NSNotification) {
        super.dataDidUpdateNotification(notification)
        updateTableView()
    }
    
    private func updateTableView() {
//        reviewDataProvider.updateWithItems(TMDbReviewManager.shared.itemsInList)
        tableView.reloadData()
    }
    
    // Note: - What about authorization errors in this screen
    // Probably we should only show them when we are signed in
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if reviewDataProvider.itemCount - 5 == indexPath.row {
//            TMDbReviewManager.shared.loadMore()
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

}

