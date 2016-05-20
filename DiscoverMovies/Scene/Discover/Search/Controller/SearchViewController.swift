//
//  SearchViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class SearchViewController: DiscoverListViewController {
    
    private let searchManager = TMDbMovieSearchManager()
    private let dataProvider = DiscoverDataProvider()
    
    var search: TMDbSearchType? {
        didSet {
            guard let search = search else { return }
            performSearch(search)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up data provider
        dataProvider.cellIdentifier = "DiscoverListIdentifier"
    }
    
    // MARK: - Fetching
    
    private func performSearch(searchType: TMDbSearchType) {
        searchManager.reloadIfNeeded(true, search: searchType)
    }
    
    private func loadMore() {
        searchManager.loadMore()
    }

    // MARK: - Navigation
    
    private func showDetailViewControllerForMovie(movie: TMDbMovie) { // Paramater for backdrop image from cache
        let detailViewController = DetailViewController(movie: movie)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}
