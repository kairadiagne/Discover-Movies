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

class TopListViewController: DiscoverViewController {
    
    private let topListDataProvider = DiscoverDataProvider()
    private let topListManager = TMDbTopListManager()
    
    var switchListControl: UISegmentedControl!
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
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
        // Start Loading ??
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
        topListManager.loadMore()
    }
    
    // MARK: - Notifications
    
    func updateNotification() {
        // Stop Loading ??
        topListDataProvider.updateMovies(topListManager.movies)
        tableView.reloadData()
    }
    
    func handleError() {
        
    }
    
    // MARK: - Navigation
    
    private func showDetailViewControllerForMovie(movie: TMDbMovie) {
        let detailViewController = DetailViewController(movie: movie)
        
        if let path = movie.backDropPath, url = TMDbImageRouter.BackDropMedium(path: path).url {
            detailViewController.image = SDWebImageManager.sharedManager().cachedImageForURL(url)
        }
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
}


