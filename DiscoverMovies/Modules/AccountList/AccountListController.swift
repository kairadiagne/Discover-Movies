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

final class AccountListController: BaseViewController {
    
    // MARK: - Types
    
    private struct Constants {
        static let DefaultRowHeight: CGFloat = 100
    }
    
    // MARK: - Properties

    @IBOutlet var accountListView: AccountListView!
    
    private let dataSource = AccountListDataSource()
    
    private let accountList: String
    
    private let accountListManager: AccountListDataManager
    
    // MARK: - Initialize
    
    init(list aList: String, manager: AccountListDataManager) {
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
        
        accountListView.tableView.register(nibReusableCell: AccountListTableViewCell.self)
        accountListView.tableView.register(nibReusableCell: NoDataCell.self)
        accountListView.tableView.delegate = self
        accountListView.tableView.dataSource = dataSource
        
        accountListView.refreshControl.addTarget(self, action: #selector(AccountListController.refresh(_:)), for: .valueChanged)
        
        if accountList == "favorite" {
            title = "favoriteVCTitle".localized
        } else {
            title = "watchListVCTitle".localized
        }
    }
    // MARK: - Refresh
    
    @objc private func refresh(_ sender: UIRefreshControl) {
    }
    
    // MARK: - Notifications
    
//    override func detailManagerDidUpdate(notification: Notification) {
//        accountListView.set(state: .idle)
//        dataSource.items = accountListManager.allItems
//        accountListView.tableView.reloadData()
//    }
    
//    override func dataManagerDidStartLoading(notification: Notification) {
//        accountListView.set(state: .loading)
//    }
    
    // MARK: - Failuredelegate
    
//    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
//        ErrorHandler.shared.handle(error: error, authorizationError: true)
//        accountListView.set(state: .idle)
//        accountListView.tableView.reloadData()
//    }
}

// MARK: - UITableViewDelegate

extension AccountListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
//        showDetailViewController(for: movie, signedIn: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if accountListView.state == .loading && dataSource.isEmpty {
            cell.isHidden = true
        } else if dataSource.itemCount - 5 == indexPath.row {
//            accountListManager.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !dataSource.isEmpty ? UITableView.automaticDimension : tableView.bounds.height
    }
}
