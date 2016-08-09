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
    
    private var currentList: TMDbToplist = .Popular
    
    private var currentManager: TMDbTopListManager?
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let switchListSelector = #selector(TopListViewController.switchTopList(_:))
        switchListControl = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming"])
        switchListControl.addTarget(self, action: switchListSelector, forControlEvents: .ValueChanged)
        switchListControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = switchListControl
        
        TMDbPopularListManager.shared.failureDelegate = self
        TMDbTopRatedListManager.shared.failureDelegate = self
        TMDbUpcomingListManager.shared.failureDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        let loadingSelector = #selector(TopListViewController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(TopListViewController.dataDidLoadTopNotification(_:))
        let didUpdateSelector = #selector(TopListViewController.dataDidUpdateNotification(_:))
        TMDbPopularListManager.shared.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector, didUpdateSelector: didUpdateSelector)
        TMDbTopRatedListManager.shared.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector, didUpdateSelector: didUpdateSelector)
        TMDbUpcomingListManager.shared.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector, didUpdateSelector: didUpdateSelector)

        switchTopList(switchListControl)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        TMDbPopularListManager.shared.removeObserver(self)
        TMDbTopRatedListManager.shared.removeObserver(self)
        TMDbUpcomingListManager.shared.removeObserver(self)
    }
    
    // MARK: Fetching
    
    func switchTopList(control: UISegmentedControl) {
        switch switchListControl.selectedSegmentIndex {
        case 0:
            currentList = .Popular
            currentManager = TMDbPopularListManager.shared
        case 1:
            currentList = .TopRated
            currentManager = TMDbTopRatedListManager.shared
        case 2:
            currentList = .Upcoming
            currentManager = TMDbUpcomingListManager.shared
        default:
            return
        }
        
        currentManager?.reloadTopIfNeeded(true)
    }
    
    // MARK: Notifications
    
    override func dataDidLoadTopNotification(notification: NSNotification) {
        super.dataDidLoadTopNotification(notification)
        updateTableView(true)
    }
    
    override func dataDidUpdateNotification(notification: NSNotification) {
        super.dataDidUpdateNotification(notification)
        updateTableView()
    }
    
    private func updateTableView(scrollToTop: Bool = false) {
        guard let items = currentManager?.itemsInList else { return }
        tableViewDataProvider.updateWithItems(items)
        tableView.reloadData()
        
        if scrollToTop {
            tableView.scrollToTop()
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let movie = tableViewDataProvider.itemAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableViewDataProvider.itemCount - 10 == indexPath.row {
            currentManager?.loadMore()
        }
    }

}
