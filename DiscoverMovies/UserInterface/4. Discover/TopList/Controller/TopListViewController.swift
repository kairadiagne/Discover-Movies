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
    
    // MARK: View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let switchListSelector = #selector(TopListViewController.switchTopList(_:))
        switchListControl = UISegmentedControl(items: ["Popular", "Top Rated", "Upcoming"])
        switchListControl.addTarget(self, action: switchListSelector, forControlEvents: .ValueChanged)
        switchListControl.selectedSegmentIndex = 0
        self.navigationItem.titleView = switchListControl
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        topListDataManager.addChangeObserver(self, selector: #selector(TopListViewController.dataDidChangeNotification(_:)))
        switchTopList(switchListControl)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        topListDataManager.removeObserver(self)
    }
    
    // MARK: Fetching
    
    func switchTopList(control: UISegmentedControl) {
        switch switchListControl.selectedSegmentIndex {
        case 0:
            topListDataManager.loadTop(.Popular)
        case 1:
            topListDataManager.loadTop(.TopRated)
        case 2:
            topListDataManager.loadTop(.Upcoming)
        default:
            return
        }
    }
    
    // MARK: Notifications
    
    override func dataDidChangeNotification(notification: NSNotification) {
        super.dataDidChangeNotification(notification)
        
        switch topListDataManager.state {
        case .Loading:
            showProgressHUD()
        case .DataDidLoad:
            updateTableView()
        case .DataDidUpdate:
            updateTableView()
            tableView.scrollToTop()
        case .NoData:
            tableView.showMessage("No Data")
        case .Error:
            handleErrorState(topListDataManager.lastError)
         default:
            return
        }
    }
    
    private func updateTableView() {
        tableViewDataProvider.updateWithItems(topListDataManager.movies)
        tableView.reloadData()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let movie = tableViewDataProvider.itemAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableViewDataProvider.itemCount - 5 == indexPath.row {
            topListDataManager.loadMore()
        }
    }
    
}


