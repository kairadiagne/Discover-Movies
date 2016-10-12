//
//  SearchViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet var searchView: SearchView!
    
    fileprivate var searchController: UISearchController!
    
    fileprivate let recentSearchManager = RecentSearchManager()
    
    fileprivate let resultsTableController = SearchResultsController()
    
    fileprivate let searchManager = SearchDataManager()
    
    fileprivate let dataSource = SearchDataSource()
    
    fileprivate var searchQuery = ""
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMenuButton()
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchView.tableView.tableHeaderView = searchController.searchBar
        
        // searchController.delegate = self
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        
        // Set this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        searchView.tableView.dataSource = dataSource
        searchView.tableView.delegate = self
        
        searchManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(SearchViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(SearchViewController.dataManagerDidUpdate(notification:))
        searchManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
        
        searchView.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchManager.remove(observer: self)
    }
    
    // MARK: - Notifications
    
    override func dataManagerDidUpdate(notification: Notification) {
        resultsTableController.update(withItems: searchManager.allItems)
        resultsTableController.tableView.reloadData()
    }
    
    // MARK: - FailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
         ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }

}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return searchView.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
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
            guard searchQuery.characters.count > 0 else {
                // Make sure the results screen is cleared
                if !resultsTableController.isEmpty {
                    resultsTableController.clear()
                    resultsTableController.tableView.reloadData()
                }
                
                return
            }

            // Check if last character added was white space
            guard searchQuery.characters.last != " " else { return }
            
            // Perform search
            searchManager.search(for: searchQuery)
        }
    }
    
}

// MARK: - UISearchBarDelegate 

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        recentSearchManager.recentSearches.append(searchQuery)
//        dataSource.update(withItems: recentSearchManager.recentSearches)
        searchView.tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
}



