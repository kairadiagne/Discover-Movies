//
//  AccountListController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/06/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class AccountListController: ListViewController, MenuButtonPresentable, PullToRefreshable {
    
    // MARK: Types
    
    fileprivate struct Constants {
        static let DefaultRowHeight: CGFloat = 100
    }
    
    // MARK: Properties
    
    fileprivate let dataProvider = AccountListDataProvider()
    
    fileprivate let accountList: TMDbAccountList
    
    fileprivate let accountListManager: TMDbAccountListDataManager
    
    // MARK: Initialize
    
    init(list aList: TMDbAccountList) {
        self.accountList = aList
        self.accountListManager = TMDbAccountListDataManager(list: aList)
        super.init(nibName: "ListViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuButton()
        
        accountListManager.failureDelegate = self
        
        let nib = UINib(nibName: AccountListTableViewCell.nibName(), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AccountListTableViewCell.defaultIdentifier())
        tableView.estimatedRowHeight = Constants.DefaultRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataProvider
        
        title = accountList.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(AccountListController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(AccountListController.dataDidLoadTopNotification(_:))
        accountListManager.add(observer: self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)
        accountListManager.failureDelegate = self
        accountListManager.reloadIfNeeded(forceOnline: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        accountListManager.remove(observer: self)
    }
    
    // MARK: Refresh
    
    func refresh(_ sender: UIRefreshControl) {
        accountListManager.reloadIfNeeded(forceOnline: true)
    }
    
    // MARK: Notifications 
    
    override func dataDidLoadTopNotification(_ notification: Notification) {
        super.dataDidLoadTopNotification(notification)
        updateTableView()
    }
    
    func updateTableView() {
        let items = accountListManager.allItems
        
        if items.count == 0 {
            tableView.showMessage("This list doesn't contain any movies yet") // NSLocalizedString
        } else {
            dataProvider.updateWithItems(items)
        }
        
        tableView.reloadData()
    }

    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        guard let movie = dataProvider.itemAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if dataProvider.itemCount - 5 == (indexPath as NSIndexPath).row {
            accountListManager.loadMore()
        }
    }
    
    // MARK: Navigation 
    
    func showDetailViewControllerForMovie(_ movie: Movie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

