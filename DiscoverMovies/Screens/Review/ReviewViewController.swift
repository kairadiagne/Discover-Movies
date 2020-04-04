//
//  ReviewViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

final class ReviewViewController: UIViewController {
    
    // MARK: - Types
    
    private struct Constants {
        static let DefaultRowHeight: CGFloat = 200
    }
    
    // MARK: - Properties
    
    @IBOutlet var reviewView: ReviewView!
    
    private let movie: MovieRepresentable
 
//    private let reviewDataSource = ReviewDataSource(emptyMessage: "noReviewMessage".localized)
    
    private let reviewManager: MovieReviewManager
    
    private let signedIn: Bool
    
    // MARK: - Initialize
    
    init(movie: MovieRepresentable, signedIn: Bool) {
        self.movie = movie
        self.reviewManager = MovieReviewManager(movieID: movie.identifier)
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
//        reviewView.tableView.dataSource = reviewDataSource
        reviewView.tableView.delegate = self
        
        reviewView.refreshControl.addTarget(self, action: #selector(ReviewViewController.refresh), for: .valueChanged)
    
        title = "reviewvcTitle".localized
    }
    
    @objc private func refresh() {
    }
    
    // MARK: - DataManagerNotifications
    
//    override func dataManagerDidStartLoading(notification: Notification) {
//        reviewView.set(state: .loading)
//    }
//    
//    override func detailManagerDidUpdate(notification: Notification) {
//        reviewView.set(state: .idle)
//        reviewDataSource.items = reviewManager.allItems
//        reviewView.tableView.reloadData()
//    }
    
    // MARK: - DataManagerFailureDelegate
    
//    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
//        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
//        reviewView.set(state: .idle)
//        reviewView.tableView.reloadData()
//    }
}

// MARK: UITableViewDelegate

extension ReviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.DefaultRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
//        return !reviewDataSource.isEmpty ? UITableView.automaticDimension : tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        return
//        if reviewView.state == .loading && reviewDataSource.isEmpty {
//            cell.isHidden = true
//        } else if reviewDataSource.isEmpty {
//            cell.separatorInset.left = view.bounds.width
//        } else if reviewDataSource.itemCount - 5 == indexPath.row {
////            reviewManager.loadMore()
//        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
