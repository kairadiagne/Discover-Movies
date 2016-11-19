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
    
    fileprivate var searchController: UISearchController!
    
    fileprivate let searchManager = SearchDataManager()
    
    fileprivate let dataSource = SearchDataSource()
    
    fileprivate var searchQuery = ""
    
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
        
        let searchCellNib = UINib(nibName: SearchTableViewCell.nibName(), bundle: nil)
        searchView.tableView.register(searchCellNib, forCellReuseIdentifier: SearchTableViewCell.defaultIdentifier())
        
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = dataSource
        
        extendedLayoutIncludesOpaqueBars = true
        
        searchView.tableView.keyboardDismissMode = .onDrag
        
        searchManager.failureDelegate = self
        
        title = NSLocalizedString("searchVCTitle", comment: "")
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
        return searchView.tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = dataSource.item(atIndex: indexPath.row) else { return }
        
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.delegate = detailViewController
        navigationController?.pushViewController(detailViewController, animated: true)
        
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
            guard searchQuery.characters.count > 0 else {
                // Make sure the results screen is cleared
                if !dataSource.isEmpty {
                    dataSource.clear()
                    searchView.tableView.reloadData()
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
