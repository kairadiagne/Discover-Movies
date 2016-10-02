//
//  ReviewViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class ReviewViewController: BaseViewController {
    
    // MARK: - Types
    
    fileprivate struct Constants {
        static let DefaultRowHeight: CGFloat = 200
    }
    
    // MARK: - Properties
    
    @IBOutlet var reviewView: ReviewView!
    
    fileprivate let movie: Movie
 
    fileprivate let reviewDataSource = ReviewDataSource()
    
    fileprivate let reviewManager: TMDbReviewManager
    
    // MARK: - Initialize
    
    init(movie: Movie) {
        self.movie = movie
        self.reviewManager = TMDbReviewManager(movieID: movie.id)
        super.init(nibName: "ReviewViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reviewCellNib = UINib(nibName: ReviewTableViewCell.nibName(), bundle: nil)
        reviewView.tableView.register(reviewCellNib, forCellReuseIdentifier: ReviewTableViewCell.defaultIdentifier())
        reviewView.tableView.dataSource = reviewDataSource
        reviewView.tableView.delegate = self
    
        title = "Reviews" // NSLocalizedString
        
        reviewManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(ReviewViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(ReviewViewController.dataManagerDidUpdate(notification:))
        reviewManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)

         reviewManager.reloadIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reviewManager.remove(observer: self)
    }
    
    // MARK: - DataManagerNotifications
    
    override func dataManagerDidStartLoading(notification: Notification) {
        reviewView.set(state: .loading)
    }
    
    override func dataManagerDidUpdate(notification: Notification) {
        reviewView.set(state: .idle)
        reviewDataSource.update(withItems: reviewManager.allItems)
        reviewView.tableView.reloadData()
    }
    
    // MARK: - DataManagerFailureDelegate
    
    // Note: - What about authorization errors in this screen
    // Probably we should only show them when we are signed in
}

// MARK: UITableViewDelegate

extension ReviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.DefaultRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return reviewDataSource.isEmpty ? tableView.bounds.height : UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if reviewDataSource.itemCount - 5 == indexPath.row {
            reviewManager.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

