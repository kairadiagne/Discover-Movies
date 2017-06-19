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
    
    private let movie: MovieRepresentable
 
    fileprivate let reviewDataSource = ReviewDataSource(emptyMessage: "noReviewMessage".localized)
    
    fileprivate let reviewManager: TMDbReviewManager
    
    private let signedIn: Bool
    
    // MARK: - Initialize
    
    init(movie: MovieRepresentable, signedIn: Bool) {
        self.movie = movie
        self.reviewManager = TMDbReviewManager(movieID: movie.id)
        self.signedIn = signedIn
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewView.tableView.register(ReviewTableViewCell.nib, forCellReuseIdentifier: ReviewTableViewCell.reuseId)
        reviewView.tableView.register(NoDataCell.nib, forCellReuseIdentifier: NoDataCell.reuseId)
        reviewView.tableView.dataSource = reviewDataSource
        reviewView.tableView.delegate = self
        
        reviewView.refreshControl.addTarget(self, action: #selector(ReviewViewController.refresh), for: .valueChanged)
    
        title = "reviewvcTitle".localized
        
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
    
    @objc fileprivate func refresh() {
        reviewManager.reloadIfNeeded(forceOnline: true)
    }
    
    // MARK: - DataManagerNotifications
    
    override func dataManagerDidStartLoading(notification: Notification) {
        reviewView.set(state: .loading)
    }
    
    override func dataManagerDidUpdate(notification: Notification) {
        reviewView.set(state: .idle)
        reviewDataSource.items = reviewManager.allItems
        reviewView.tableView.reloadData()
    }
    
    // MARK: - DataManagerFailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }
    
}

// MARK: UITableViewDelegate

extension ReviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.DefaultRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !reviewDataSource.isEmpty ? UITableViewAutomaticDimension : tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if reviewView.state == .loading && reviewDataSource.isEmpty {
            cell.isHidden = true
        } else if reviewDataSource.isEmpty {
            cell.separatorInset.left = view.bounds.width
        } else if reviewDataSource.itemCount - 5 == indexPath.row {
            reviewManager.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

