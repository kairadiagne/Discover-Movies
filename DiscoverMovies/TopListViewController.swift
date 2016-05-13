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

class TopListViewController: ListViewController, MenuButtonPresentable {
    
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
        topListDataProvider.didSelectBlock = TopListViewController.showDetailViewControllerForMovie(self)
        topListDataProvider.loadMoreBlock = TopListViewController.loadMore(self)
        tableView.dataSource = topListDataProvider
        tableView.delegate = topListDataProvider
        
        // Configure UISegmented control for switching lists
        let switchListSelector = #selector(TopListViewController.switchTopList(_:))
        switchListControl = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming"])
        switchListControl.addTarget(self, action: switchListSelector, forControlEvents: .ValueChanged)
        switchListControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = switchListControl
        
        // Sign up for Notifications 
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let selector = #selector(TopListViewController.updateNotification)
        notificationCenter.addObserver(self, selector: selector, name: TMDManagerDataDidChangeNotification, object: nil)
        let errorSelector = #selector(TopListViewController.handleError)
        notificationCenter.addObserver(self, selector: errorSelector, name: TMDbManagerDidReceiveErrorNotification, object: nil)
        
        // Perform initial fetch
        switchTopList(switchListControl)
    }
    
    deinit {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Fetching
    
    func switchTopList(control: UISegmentedControl) {
        // Start Loading
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
    
    private func loadMore() {
        if !topListManager.inProgress {
            topListManager.loadMore()
        }
    }
    
    // MARK: - Notifications
    
    override func updateNotification(notification: NSNotification) {
        super.updateNotification(notification)
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


