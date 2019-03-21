//
//  SearchViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SWRevealViewController

class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet var searchView: SearchView!
    
    private var searchController: UISearchController!
    
    private let searchManager = SearchDataManager()
    
    private let dataSource = SearchDataSource(emptyMessage: "noSearchResultsText".localized)
    
    private var searchQuery = ""
    
    private let signedIn: Bool
    
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
        
        addMenuButton()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchView.tableView.tableHeaderView = searchController.searchBar
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        searchView.tableView.register(SearchTableViewCell.nib, forCellReuseIdentifier: SearchTableViewCell.reuseId)
        searchView.tableView.register(NoDataCell.nib, forCellReuseIdentifier: NoDataCell.reuseId)
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = dataSource
        
        extendedLayoutIncludesOpaqueBars = true
        
        searchView.tableView.keyboardDismissMode = .onDrag
        
        searchManager.failureDelegate = self
        
        title = "searchVCTitle".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(SearchViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(SearchViewController.dataManagerDidUpdate(notification:))
        searchManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        revealViewController().delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !searchController.isActive {
            searchController.isActive = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchManager.remove(observer: self)
        
        revealViewController().delegate = nil
    }
    
    // MARK: - Notifications
    
    override func dataManagerDidUpdate(notification: Notification) {
        dataSource.items = searchManager.allItems
        searchView.tableView.reloadData()
    }
    
    // MARK: - FailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
        searchView.tableView.reloadData()
    }
    
    // MARK: - SWRevealControllerDelegate
    
    override func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        super.revealController(revealController, willMoveTo: position)
        
        if position.rawValue == 4 {
            searchController.searchBar.resignFirstResponder()
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource.isEmpty ? tableView.bounds.height: searchView.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
        showDetailViewController(for: movie, signedIn: signedIn)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if dataSource.itemCount - 10 == indexPath.row {
            searchManager.loadMore()
        }
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    // Called when the search bar becomes the first responder or when
    // The user makes changes inside the search bar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchFieldtext = searchController.searchBar.text {
            // Update Search query
            searchQuery = searchFieldtext
            
            // Check if query is empty
            guard searchQuery.count > 0 else {
                // Make sure the results screen is cleared
                if !dataSource.isEmpty {
                    dataSource.clear()
                    searchView.tableView.reloadData()
                }
                
                return
            }

            // Check if last character added was white space
            guard searchQuery.last != " " else { return }
            
            // Perform search
            searchManager.search(for: searchQuery)
        }
    }
}

// MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}

// MARK: - UISearchBarDelegate 

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
