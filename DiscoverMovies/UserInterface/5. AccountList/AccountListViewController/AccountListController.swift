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
    
    // MARK: Initializers
    
    init(list aList: TMDbAccountList) {
        self.accountList = aList
        super.init(nibName: "ListViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMenuButton()
        
        TMDbAccountListDataManager.shared.failureDelegate = self
        
        let nib = UINib(nibName: AccountListTableViewCell.nibName(), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: AccountListTableViewCell.defaultIdentifier())
        tableView.estimatedRowHeight = Constants.DefaultRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataProvider
        
        title = accountList.rawValue
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(AccountListController.dataDidStartLoadingNotification(_:))
        let didLoadSelector = #selector(AccountListController.dataDidLoadTopNotification(_:))
        let didUpdateSelector = #selector(AccountListController.dataDidUpdateNotification(_:))
        TMDbAccountListDataManager.shared.addObserver(self, loadingSelector: loadingSelector, didLoadSelector: didLoadSelector, didUpdateSelector: didUpdateSelector)
        TMDbAccountListDataManager.shared.failureDelegate = self
        TMDbAccountListDataManager.shared.list = accountList
        TMDbAccountListDataManager.shared.reloadTopIfNeeded(false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        TMDbAccountListDataManager.shared.removeObserver(self)
    }
    
    // MARK: Refresh
    
    func refresh(sender: UIRefreshControl) {
        TMDbAccountListDataManager.shared.reloadTopIfNeeded(true)
    }
    
    // MARK: Notifications 
    
    override func dataDidLoadTopNotification(notification: NSNotification) {
        super.dataDidLoadTopNotification(notification)
        updateTableView()
    }
    
    override func dataDidUpdateNotification(notification: NSNotification) {
        super.dataDidUpdateNotification(notification)
        updateTableView()
    }
    
    func updateTableView() {
        dataProvider.updateWithItems(TMDbAccountListDataManager.shared.itemsInList)
        if TMDbAccountListDataManager.shared.itemsInList.count == 0 {
            tableView.showMessage("This list doesn't contain any movies yet") // NSLocalizedString
        }
        tableView.reloadData()
    }

    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let movie = dataProvider.itemAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if dataProvider.itemCount - 5 == indexPath.row {
            TMDbAccountListDataManager.shared.loadMore()
        }
    }
    
    // MARK: Navigation 
    
    func showDetailViewControllerForMovie(movie: TMDbMovie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
}

