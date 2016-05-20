//
//  TopListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class TopListViewController: DiscoverListViewController, MenuButtonPresentable {
    
    private let topListDataProvider = DiscoverDataProvider()
    private let topListManager = TMDbTopListManager()
    
    var switchListControl: UISegmentedControl!
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add menu button to navigation bar
        addMenuButton()
    
        // Set up the topListDataProvider
        topListDataProvider.cellIdentifier = "DiscoverListIdentifier"
        tableView.dataSource = topListDataProvider
        tableView.delegate = self
        
        // Sign up for notifications from toplistDataManager
        signUpForUpdateNotification(topListManager)
        signUpForChangeNotification(topListManager)
        signUpErrorNotification(topListManager)
        
        // Configure UISegmented control for switching lists
        let switchListSelector = #selector(TopListViewController.switchTopList(_:))
        switchListControl = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming"])
        switchListControl.addTarget(self, action: switchListSelector, forControlEvents: .ValueChanged)
        switchListControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = switchListControl
        
        // Perform initial fetch
        switchTopList(switchListControl)
    }
    
    deinit {
        stopObservingNotifications()
    }
    
    // MARK: - Fetching
    
    func switchTopList(control: UISegmentedControl) {
        showProgressHUD()
        
        // Request List
        switch switchListControl.selectedSegmentIndex {
        case 0:
            topListManager.reloadTopIfNeeded(true, list: .Popular)
        case 1:
            topListManager.reloadTopIfNeeded(true, list: .TopRated)
        case 2:
            topListManager.reloadTopIfNeeded(true, list: .Upcoming)
        default:
            print("Unexpected error occurred")
        }
    }
    
    // MARK: - Notifications
    
    override func updateNotification(notification: NSNotification) {
        super.updateNotification(notification)
        topListDataProvider.updateMovies(topListManager.movies)
        tableView.reloadData()
    }
    
    override func changeNotification(notification: NSNotification) {
        super.changeNotification(notification)
        topListDataProvider.updateMovies(topListManager.movies)
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    private func showDetailViewControllerForMovie(movie: TMDbMovie) {
        let (image, url) = SDWebImageManager.sharedManager().getImageFromCache(movie)
        let detailViewController = DetailViewController(movie: movie, image: image, imageURL: url)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - UITableViewDelegate

extension TopListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let movie = topListDataProvider.movieAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if topListDataProvider.movieCount - 5 == indexPath.row {
            topListManager.loadMore()
        }
    }
}


