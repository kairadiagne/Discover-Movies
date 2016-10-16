//
//  HomeViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SDWebImage

class HomeViewController: BaseViewController {
    
    // MARK: - Types
    
    fileprivate struct Constants {
        static let CellHeight: CGFloat = 250
    }
    
    // MARK: - Properties
    
    @IBOutlet var homeView: HomeView!
    
    fileprivate let popularListManager = TMDbTopListDataManager(list: .popular)
    
    fileprivate let topRatedListManager = TMDbTopListDataManager(list: .topRated)
    
    fileprivate let upcomingListManager = TMDbTopListDataManager(list: .upcoming)
    
    fileprivate let nowPlayingListManager = TMDbTopListDataManager(list: .nowPlaying)
    
    fileprivate let popularListDataSource = TopListDataSource()
    
    fileprivate let topRatedListDataSource = TopListDataSource()
    
    fileprivate let upcomingListDataSource = TopListDataSource()
    
    fileprivate let nowplayingListDataSource = TopListDataSource()
    
    fileprivate var currentList: TMDbTopList = .popular
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("homevcTitle", comment: "")
        
        addMenuButton()
        
        homeView.tableView.delegate = self
        
        let movieCellnib = UINib(nibName: DiscoverListCell.nibName(), bundle: nil)
        homeView.tableView.register(movieCellnib, forCellReuseIdentifier: DiscoverListCell.defaultIdentifier())
        
        let noDataCellNib = UINib(nibName: NoDataCell.nibName(), bundle: nil)
        homeView.tableView.register(noDataCellNib, forCellReuseIdentifier: NoDataCell.defaultIdentifier())
        
        homeView.refreshControl.addTarget(self, action: #selector(HomeViewController.refresh(control:)), for: .valueChanged)
        
        popularListManager.failureDelegate = self
        topRatedListManager.failureDelegate = self
        upcomingListManager.failureDelegate = self
        nowPlayingListManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(HomeViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(HomeViewController.dataManagerDidUpdate(notification:))
        
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
        homeView.tableView.setContentOffset(.zero, animated: false)
    
        load(list: currentList)
    }
    
    // MARK: - Fetch 
    
    private func load(list: TMDbTopList) {
        let dataSource = datasource(forList: list)
        let manager = self.manager(forList: list)
        
        homeView.tableView.dataSource = dataSource
        
        // Try to preload data from cache
        dataSource.update(withItems: manager.allItems)
        homeView.tableView.reloadData()
        
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
        datasource.update(withItems: manager.allItems)
        
        homeView.set(state: .idle)
        homeView.tableView.reloadData()
    }
    
    override func dataManagerDidStartLoading(notification: Notification) {
         homeView.set(state: .loading)
    }
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
        homeView.set(state: .idle)
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
    
    fileprivate func datasource(forList list: TMDbTopList) -> TopListDataSource {
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

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !datasource(forList: currentList).isEmpty ? Constants.CellHeight : tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = datasource(forList: currentList).item(atIndex: indexPath.row) else { return }
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.delegate = detailViewController // Use coordinator pattern 
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if homeView.state == .loading && datasource(forList: currentList).isEmpty {
            cell.isHidden = true 
        } else if datasource(forList: currentList).itemCount - 10 == indexPath.row {
            manager(forList: currentList).loadMore()
        }
    }
    
}
