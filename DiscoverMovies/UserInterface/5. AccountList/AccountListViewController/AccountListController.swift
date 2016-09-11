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
    
    private struct Constants {
        static let DefaultRowHeight: CGFloat = 100
    }
    
    // MARK: Properties
    
    private let dataProvider = AccountListDataProvider()
    
    private let accountList: TMDbAccountList
    
    private let accountListManager: TMDbAccountListDataManager
    
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
        tableView.registerNib(nib, forCellReuseIdentifier: AccountListTableViewCell.defaultIdentifier())
        tableView.estimatedRowHeight = Constants.DefaultRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataProvider
        
        title = accountList.name
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(AccountListController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(AccountListController.dataDidLoadTopNotification(_:))
        accountListManager.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector)
        accountListManager.failureDelegate = self
        accountListManager.reloadIfNeeded(false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        accountListManager.removeObserver(self)
    }
    
    // MARK: Refresh
    
    func refresh(sender: UIRefreshControl) {
        accountListManager.reloadIfNeeded(true)
    }
    
    // MARK: Notifications 
    
    override func dataDidLoadTopNotification(notification: NSNotification) {
        super.dataDidLoadTopNotification(notification)
        updateTableView()
    }
    
    func updateTableView() {
        let items = accountListManager.itemsInList()
        
        if items.count == 0 {
            tableView.showMessage("This list doesn't contain any movies yet") // NSLocalizedString
        } else {
            dataProvider.updateWithItems(items)
        }
        
        tableView.reloadData()
    }

    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let movie = dataProvider.itemAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if dataProvider.itemCount - 5 == indexPath.row {
            accountListManager.loadMore()
        }
    }
    
    // MARK: Navigation 
    
    func showDetailViewControllerForMovie(movie: Movie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

