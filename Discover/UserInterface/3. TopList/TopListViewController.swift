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
    
    fileprivate let popularListManager = TMDbTopListDataManager(list: .popular)
    
    fileprivate let topRatedListManager = TMDbTopListDataManager(list: .topRated)
    
    fileprivate let upcomingListManager = TMDbTopListDataManager(list: .upcoming)
    
    fileprivate let nowPlayingListManager = TMDbTopListDataManager(list: .nowPlaying)
    
    fileprivate let popularListDataSource = MovieListDataSource()
    
    fileprivate let topRatedListDataSource = MovieListDataSource()
    
    fileprivate let upcomingListDataSource = MovieListDataSource()
    
    fileprivate let nowplayingListDataSource = MovieListDataSource()
    
    fileprivate var currentList: TMDbTopList = .popular
    
    fileprivate let signedIn: Bool
    
    // MARK: - Initialize
    
    init(signedIn: Bool) {
        self.signedIn = signedIn
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("topListVCTitle", comment: "")
        
        addMenuButton()
        
        topListView.tableView.delegate = self
        
        let movieCellnib = UINib(nibName: DiscoverListCell.nibName(), bundle: nil)
        topListView.tableView.register(movieCellnib, forCellReuseIdentifier: DiscoverListCell.defaultIdentifier())
        
        let noDataCellNib = UINib(nibName: NoDataCell.nibName(), bundle: nil)
        topListView.tableView.register(noDataCellNib, forCellReuseIdentifier: NoDataCell.defaultIdentifier())
        
        topListView.refreshControl.addTarget(self, action: #selector(TopListViewController.refresh(control:)), for: .valueChanged)
        
        popularListManager.failureDelegate = self
        topRatedListManager.failureDelegate = self
        upcomingListManager.failureDelegate = self
        nowPlayingListManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(TopListViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(TopListViewController.dataManagerDidUpdate(notification:))
        
        popularListManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        topRatedListManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        upcomingListManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        nowPlayingListManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        // Reload data if needed
        load(list: currentList)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        popularListManager.remove(observer: self)
        topRatedListManager.remove(observer: self)
        upcomingListManager.remove(observer: self)
        nowPlayingListManager.remove(observer: self)
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
        let manager = self.manager(forList: list)
        
        topListView.tableView.dataSource = dataSource
        
        // Try to preload data from cache
        dataSource.items = manager.allItems
        topListView.tableView.reloadData()
        
        // Reload data if needed
        manager.reloadIfNeeded()
    }
    
    // MARK: - Refresh
    
    @objc private func refresh(control: UIRefreshControl) {
        let manager = self.manager(forList: currentList)
        manager.reloadIfNeeded(forceOnline: true)
    }
 
    // MARK: - DataManagerNotifications 
    
    override func dataManagerDidUpdate(notification: Notification) {
        let manager = self.manager(forList: currentList)
        let datasource = self.datasource(forList: currentList)
        datasource.items = manager.allItems
        
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
    
    fileprivate func manager(forList list: TMDbTopList) -> TMDbTopListDataManager {
        switch list {
        case .popular:
            return popularListManager
        case .nowPlaying:
            return nowPlayingListManager
        case .topRated:
            return topRatedListManager
        case .upcoming:
            return upcomingListManager
        }
    }
    
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
        let detailViewController = DetailViewController(movie: movie, signedIn: signedIn)
        navigationController?.delegate = detailViewController 
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if topListView.state == .loading && datasource(forList: currentList).isEmpty {
            cell.isHidden = true 
        } else if datasource(forList: currentList).itemCount - 10 == indexPath.row {
            manager(forList: currentList).loadMore()
        }
    }
    
    
}
