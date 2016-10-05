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
    
    fileprivate var searchViewController: UISearchController!
    
    fileprivate let searchManager = SearchDataManager()
    
    fileprivate let dataSource = SearchDataSource()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchView.tableView.dataSource = dataSource
        
        // Initializing with nil means that the searchController will use this view controller
        // To display the results of the searches
        searchViewController = UISearchController(searchResultsController: nil)
        searchViewController.searchResultsUpdater = self
        
        searchViewController.dimsBackgroundDuringPresentation = false
        
        searchViewController.searchBar.sizeToFit()
        searchView.tableView.tableHeaderView = searchViewController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        searchManager.failureDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loadingSelector = #selector(SearchViewController.dataManagerDidStartLoading(notification:))
        let updateSelector = #selector(SearchViewController.dataManagerDidUpdate(notification:))
        searchManager.add(observer: self, loadingSelector: loadingSelector, updateSelector: updateSelector)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchManager.remove(observer: self)
    }
    
    // MARK: - Notifications
    
    override func dataManagerDidStartLoading(notification: Notification) {
       // Not neccesary
    }
    
    override func dataManagerDidUpdate(notification: Notification) {
        dataSource.update(withItems: searchManager.allItems)
        searchView.tableView.reloadData()
    }
    
    // MARK: - FailureDelegate
    
    override func dataManager(_ manager: AnyObject, didFailWithError error: APIError) {
        ErrorHandler.shared.handle(error: error, authorizationError: signedIn)
    }

}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    // Called when the search bar becomes the first responder or when 
    // The user makes changes inside the search bar
    func updateSearchResults(for searchController: UISearchController) {
        if let searchtext = searchController.searchBar.text {
            searchManager.search(for: searchtext)
            // If there is white space do not start a search 
            // But do remember the text
        }
    }
    
}

//func updateSearchResultsForSearchController(searchController: UISearchController) {
//    if let searchText = searchController.searchBar.text {
//        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
//            return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//        })
//        
//        tableView.reloadData()
//    }
//}
//}

