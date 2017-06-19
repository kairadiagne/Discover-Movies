//
//  TopListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class TopListViewController: BaseViewController {
    
    // MARK: - Types
    
    fileprivate struct Constants {
        static let CellHeight: CGFloat = 250
    }
    
    // MARK: - Properties
    
    @IBOutlet var topListView: topListView!
    
    fileprivate let topListProxy: TopListDataManageProxy
    
    private let popularListDataSource = MovieListDataSource()
    
    private let topRatedListDataSource = MovieListDataSource()
    
    private let upcomingListDataSource = MovieListDataSource()
    
    private let nowplayingListDataSource = MovieListDataSource()
    
    fileprivate var currentList: TMDbTopList = .popular
    
    fileprivate let signedIn: Bool
    
    // MARK: - Initialize
    
    init(signedIn: Bool, toplistProxy: TopListDataManageProxy) {
        self.signedIn = signedIn
        self.topListProxy = toplistProxy
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "topListVCTitle".localized
        
        addMenuButton()
        
        topListView.tableView.delegate = self
        topListView.tableView.register(DiscoverListCell.nib, forCellReuseIdentifier: DiscoverListCell.reuseId)
        topListView.tableView.register(NoDataCell.nib, forCellReuseIdentifier: NoDataCell.reuseId)
        
        topListView.refreshControl.addTarget(self, action: #selector(TopListViewController.refresh(control:)), for: .valueChanged)
        
        topListProxy.register(failureDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(TopListViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(TopListViewController.dataManagerDidUpdate(notification:))
        topListProxy.addObserver(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        // Reload data if needed
        load(list: currentList)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        topListProxy.remove(observer: self)
    }
    
    // MARK: - Actions
    
    @IBAction func switchList(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentList = .popular
        case 1:
            currentList = .nowPlaying
        case 2:
            currentList = .topRated
        case 3:
            currentList = .upcoming
        default:
            return
        }
        
        // Go to top
        topListView.tableView.setContentOffset(.zero, animated: false)
    
        load(list: currentList)
    }
    
    // MARK: - Fetch 
    
    private func load(list: TMDbTopList) {
        let dataSource = datasource(forList: list)
        let manager = topListProxy.manager(for: list)
        
        topListView.tableView.dataSource = dataSource
        
        // Try to preload data from cache
        dataSource.items = manager.allItems
        topListView.tableView.reloadData()
        
        // Reload data if needed
        manager.reloadIfNeeded()
    }
    
    // MARK: - Refresh
    
    @objc private func refresh(control: UIRefreshControl) {
        let manager = topListProxy.manager(for: currentList)
        manager.reloadIfNeeded(forceOnline: true)
    }
 
    // MARK: - DataManagerNotifications 
    
    override func dataManagerDidUpdate(notification: Notification) {
        let manager = topListProxy.manager(for: currentList)
        let dataSource = datasource(forList: currentList)
        dataSource.items = manager.allItems
        
        topListView.set(state: .idle)
        topListView.tableView.reloadData()
    }
    
    override func dataManagerDidStartLoading(notification: Notification) {
         topListView.set(state: .loading)
    }
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        topListView.set(state: .idle)
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }
    
    // MARK: - Utils
    
    fileprivate func datasource(forList list: TMDbTopList) -> MovieListDataSource {
        switch list {
        case .popular:
            return popularListDataSource
        case .nowPlaying:
            return nowplayingListDataSource
        case .topRated:
            return topRatedListDataSource
        case .upcoming:
            return upcomingListDataSource
        }
    }

}

extension TopListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !datasource(forList: currentList).isEmpty ? Constants.CellHeight : tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = datasource(forList: currentList).item(atIndex: indexPath.row) else { return }
        showDetailViewController(for: movie, signedIn: signedIn)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if topListView.state == .loading && datasource(forList: currentList).isEmpty {
            cell.isHidden = true 
        } else if datasource(forList: currentList).itemCount - 10 == indexPath.row {
            topListProxy.manager(for: currentList).loadMore()
        }
    }
    
    
}
