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
    
    fileprivate var currentList: TMDbTopList = .popular
    
    fileprivate let popularListManager = TMDbTopListDataManager(list: .popular)
    
    fileprivate let topRatedListManager = TMDbTopListDataManager(list: .topRated)
    
    fileprivate let upcomingListManager = TMDbTopListDataManager(list: .upcoming)
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let switchListSelector = #selector(TopListViewController.switchTopList(_:))
        switchListControl = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming"])
        switchListControl.addTarget(self, action: switchListSelector, for: .valueChanged)
        switchListControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = switchListControl
        
        popularListManager.failureDelegate = self
        topRatedListManager.failureDelegate = self
        upcomingListManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        let loadingSelector = #selector(TopListViewController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(TopListViewController.dataDidLoadTopNotification(_:))
        popularListManager.add(observer: self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)
        topRatedListManager.add(observer: self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)
        upcomingListManager.add(observer: self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        popularListManager.remove(observer: self)
        topRatedListManager.remove(observer: self)
        upcomingListManager.remove(observer: self)
        
        loadData(currentList, force: true)
    }
    
    // MARK: Fetching
    
    func switchTopList(_ control: UISegmentedControl) {
        switch switchListControl.selectedSegmentIndex {
        case 0:
            currentList = .popular
        case 1:
            currentList = .topRated
        case 2:
            currentList = .upcoming
        default:
            return
        }
        
        loadData(currentList, force: false)
    }
    
    func loadData(_ list: TMDbTopList, force: Bool) {
        managerForList(list)?.reloadIfNeeded(forceOnline: force)
    }
    
    func managerForList(_ list: TMDbTopList) -> TMDbTopListDataManager? {
        switch list {
        case .popular:
            return popularListManager
        case .topRated:
            return topRatedListManager
        case .upcoming:
            return upcomingListManager
        default:
            return nil
        }
    }
    
    
    // MARK: Notifications
    
    override func dataDidLoadTopNotification(_ notification: Notification) {
        super.dataDidLoadTopNotification(notification)
        updateTableView(true)
    }
    
    fileprivate func updateTableView(_ scrollToTop: Bool = false) {
        guard let items = managerForList(currentList)?.allItems() else { return }
        tableViewDataProvider.updateWithItems(items)
        tableView.reloadData()
        
        if scrollToTop {
            tableView.scrollToTop()
        }
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        guard let movie = tableViewDataProvider.itemAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
    }
    
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if tableViewDataProvider.itemCount - 10 == (indexPath as NSIndexPath).row {
            managerForList(currentList)?.loadMore()
        }
    }

}
