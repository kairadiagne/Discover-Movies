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
    
    private let accountListDataManager = TMDbAccountListDataManager()
    
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
        
        let nib = UINib(nibName: AccountListTableViewCell.nibName(), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: AccountListTableViewCell.defaultIdentifier())
        tableView.estimatedRowHeight = Constants.DefaultRowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = dataProvider
        
        title = accountList.rawValue
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        accountListDataManager.addChangeObserver(self, selector: #selector(AccountListController.dataDidChangeNotification(_:)))
        loadList()
    }
    
    private func loadList() {
        accountListDataManager.loadTop(accountList)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        accountListDataManager.removeObserver(self)
    }
    
    // MARK: Refresh
    
    func refresh(sender: UIRefreshControl) {
        accountListDataManager.loadTop(accountList)
    }
    
    override func dataDidChangeNotification(notification: NSNotification) {
        super.dataDidChangeNotification(notification)
        
        switch accountListDataManager.state {
        case .Loading:
            showProgressHUD()
        case .DataDidLoad:
            updateTableView()
        case .DataDidUpdate:
            updateTableView()
            tableView.scrollToTop()
        case .NoData:
            tableView.showMessage("This list doesn't contain any movies yet") // NSLocalizedString
        case .Error:
            handleErrorState(accountListDataManager.lastError, authorizationRequired: true)
        default:
            return
        }
    }
    
    func updateTableView() {
        dataProvider.updateWithItems(accountListDataManager.movies)
        tableView.reloadData()
    }

    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let movie = dataProvider.itemAtIndex(indexPath.row) else { return }
        showDetailViewControllerForMovie(movie)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if dataProvider.itemCount - 5 == indexPath.row {
            accountListDataManager.loadMore()
        }
    }
    
    // MARK: Navigation 
    
    func showDetailViewControllerForMovie(movie: TMDbMovie) {
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    
}

