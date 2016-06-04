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

class TopListViewController: DiscoverListViewController {
    
    // MARK: Properties
    
    var switchListControl: UISegmentedControl!
    
    private let topListDataManager = TMDbTopListManager()
    
    private var topListDataManagerListener: TMDbDataManagerListener<TMDbTopListManager>!
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        topListDataManagerListener = TMDbDataManagerListener(delegate: self, manager: topListDataManager)
        
        let switchListSelector = #selector(TopListViewController.switchTopList(_:))
        switchListControl = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming"])
        switchListControl.addTarget(self, action: switchListSelector, forControlEvents: .ValueChanged)
        switchListControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = switchListControl
        
        switchTopList(switchListControl) // Fetch Data
    }
    
    // MARK: Fetching
    
    func switchTopList(control: UISegmentedControl) {
        showProgressHUD()
        
        switch switchListControl.selectedSegmentIndex {
        case 0:
            topListDataManager.reloadTopIfNeeded(true, list: .Popular)
        case 1:
            topListDataManager.reloadTopIfNeeded(true, list: .TopRated)
        case 2:
            topListDataManager.reloadTopIfNeeded(true, list: .Upcoming)
        default:
            print("Unexpected error occurred")
        }
    }
    
    // MARK: Notifications
    
    override func dataManagerDataDidChangeNotification(notification: NSNotification) {
        super.dataManagerDataDidChangeNotification(notification)
        updateData()
    }
    
    override func dataManagerDataDidUpdateNotification(notification: NSNotification) {
        super.dataManagerDataDidChangeNotification(notification)
        updateData()
    }
    
    private func updateData() {
        tableViewDataProvider.updateMovies(topListDataManager.movies)
        tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let movie = tableViewDataProvider.movieAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableViewDataProvider.movieCount - 5 == indexPath.row {
            topListDataManager.loadMore()
        }
    }
    
}



