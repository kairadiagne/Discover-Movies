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

class AccountListController: BaseViewController {
    
    // MARK: - Types
    
    private struct Constants {
        static let DefaultRowHeight: CGFloat = 100
    }
    
    // MARK: - Properties

    @IBOutlet var accountListView: AccountListView!
    
    private let dataSource = AccountListDataSource()
    
    private let accountList: TMDbAccountList
    
    private let accountListManager: TMDbAccountListDataManager
    
    // MARK: - Initialize
    
    init(list aList: TMDbAccountList, manager: TMDbAccountListDataManager) {
        self.accountList = aList
        self.accountListManager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountListView.tableView.register(AccountListTableViewCell.nib, forCellReuseIdentifier: AccountListTableViewCell.reuseId)
        accountListView.tableView.register(NoDataCell.nib, forCellReuseIdentifier: NoDataCell.reuseId)
        accountListView.tableView.delegate = self
        accountListView.tableView.dataSource = dataSource
        
        accountListView.refreshControl.addTarget(self, action: #selector(AccountListController.refresh(_:)), for: .valueChanged)
        
        accountListManager.failureDelegate = self
        
        if accountList == .favorite {
            title = "favoriteVCTitle".localized
        } else {
            title = "watchListVCTitle".localized
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(AccountListController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(AccountListController.dataManagerDidUpdate(notification:))
        accountListManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)

        // Try to preload data from cache
        dataSource.items = accountListManager.allItems
        accountListView.tableView.reloadData()
        
        accountListManager.reloadIfNeeded(forceOnline: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        accountListManager.remove(observer: self)
    }
    
    // MARK: - Refresh
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        accountListManager.reloadIfNeeded(forceOnline: true)
    }
    
    // MARK: - Notifications
    
    override func dataManagerDidUpdate(notification: Notification) {
        accountListView.set(state: .idle)
        dataSource.items = accountListManager.allItems
        accountListView.tableView.reloadData()
    }
    
    override func dataManagerDidStartLoading(notification: Notification) {
        accountListView.set(state: .loading)
    }
    
    // MARK: - Failuredelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: true)
        accountListView.set(state: .idle)
        accountListView.tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension AccountListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
        showDetailViewController(for: movie, signedIn: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if accountListView.state == .loading && dataSource.isEmpty {
            cell.isHidden = true
        } else if dataSource.itemCount - 5 == indexPath.row {
            accountListManager.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !dataSource.isEmpty ? UITableView.automaticDimension : tableView.bounds.height
    }
}
