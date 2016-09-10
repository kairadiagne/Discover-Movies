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
    
    private var currentList: TMDbTopList = .Popular
    
    private let popularListManager = TMDbTopListDataManager(list: .Popular)
    
    private let topRatedListManager = TMDbTopListDataManager(list: .TopRated)
    
    private let upcomingListManager = TMDbTopListDataManager(list: .Upcoming)
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let switchListSelector = #selector(TopListViewController.switchTopList(_:))
        switchListControl = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming"])
        switchListControl.addTarget(self, action: switchListSelector, forControlEvents: .ValueChanged)
        switchListControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = switchListControl
        
        popularListManager.failureDelegate = self
        topRatedListManager.failureDelegate = self
        upcomingListManager.failureDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        let loadingSelector = #selector(TopListViewController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(TopListViewController.dataDidLoadTopNotification(_:))
        popularListManager.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)
        topRatedListManager.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)
        upcomingListManager.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        popularListManager.removeObserver(self)
        topRatedListManager.removeObserver(self)
        upcomingListManager.removeObserver(self)
        
        loadData(currentList, force: false)
    }
    
    // MARK: Fetching
    
    func switchTopList(control: UISegmentedControl) {
        switch switchListControl.selectedSegmentIndex {
        case 0:
            currentList = .Popular
        case 1:
            currentList = .TopRated
        case 2:
            currentList = .Upcoming
        default:
            return
        }
        
        loadData(currentList, force: false)
    }
    
    func loadData(list: TMDbTopList, force: Bool) {
        managerForList(list)?.reloadIfNeeded(force)
    }
    
    func managerForList(list: TMDbTopList) -> TMDbTopListDataManager? {
        switch list {
        case .Popular:
            return popularListManager
        case .TopRated:
            return topRatedListManager
        case .Upcoming:
            return upcomingListManager
        default:
            return nil
        }
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
        guard let items = managerForList(currentList)?.itemsInList() else { return }
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
            managerForList(currentList)?.loadMore()
        }
    }

}
