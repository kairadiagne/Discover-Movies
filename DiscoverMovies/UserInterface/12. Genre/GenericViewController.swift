//
//  GenreViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 19-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class GenericViewController: BaseViewController {
    
    // MARK: - Types
    
    fileprivate struct Constants {
        static let CellHeight: CGFloat = 250
    }
    
    // MARK: - Properties
    
    var genericView: GenericView {
        return view as! GenericView
    }

    fileprivate let dataManager: ListDataManager<Movie>
    
    fileprivate let dataSource = MovieListDataSource()
    
    fileprivate let signedIn: Bool
    
    // MARK: - Initialize
    
    init(dataManager: ListDataManager<Movie>, titleString: String, signedIn: Bool) {
        self.dataManager = dataManager
        self.signedIn = signedIn
        super.init(nibName: nil, bundle: nil)
        self.title = titleString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = GenericView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        genericView.tableView.register(DiscoverListCell.nib, forCellReuseIdentifier: DiscoverListCell.reuseId)
        genericView.tableView.register(NoDataCell.nib, forCellReuseIdentifier: NoDataCell.reuseId)
        genericView.tableView.delegate = self
        genericView.tableView.dataSource = dataSource
        
        genericView.refreshControl.addTarget(self, action: #selector(GenericViewController.refresh(control:)), for: .valueChanged)
       
        dataManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(GenericViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(GenericViewController.dataManagerDidUpdate(notification:))
        dataManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataManager.remove(observer: self)
    }
    
    // MARK: - Actions
    
    @objc private func refresh(control: UIRefreshControl) {
        dataManager.reloadIfNeeded(forceOnline: true)
    }
    
    private func loadData() {
        // Try to preload data from cache
        dataSource.items = dataManager.allItems
        genericView.tableView.reloadData()
        
        dataManager.reloadIfNeeded()
    }
    
    // MARK: - DataManagerNotifications
    
    override func dataManagerDidUpdate(notification: Notification) {
        genericView.set(state: .idle)
        dataSource.items = dataManager.allItems
        genericView.tableView.reloadData()
    }
    
    override func dataManagerDidStartLoading(notification: Notification) {
        genericView.set(state: .loading)
    }
    
    // MARK: - DataManagerFailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        genericView.set(state: .idle)
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }

}

// MARK: - UITableViewDelegate

extension GenericViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return !dataSource.isEmpty ? Constants.CellHeight : tableView.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
        showDetailViewController(for: movie, signedIn: signedIn)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if genericView.state == .loading && dataSource.isEmpty {
            cell.isHidden = true
        } else if dataSource.itemCount - 10 == indexPath.row {
            dataManager.loadMore()
        }
    }

}
