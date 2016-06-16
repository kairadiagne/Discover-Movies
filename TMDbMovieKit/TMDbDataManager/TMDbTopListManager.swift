//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class TMDbTopListManager: TMDbBaseDataManager {
    
    // MARK: Properties
    
    public var movies: [TMDbMovie] {
        guard let results = resultsForCurrentList(currentList) else { return [] }
        return results.items
    }
    
    public var page = 1
    
    private var currentList: TMDbToplist?

    private let movieClient = TMDbMovieClient()
    
    private var popular = TMDbList<TMDbMovie>()
    
    private var topRated = TMDbList<TMDbMovie>()
    
    private var upcoming = TMDbList<TMDbMovie>()
    
    private var nowPlaying = TMDbList<TMDbMovie>()
    
    // MARK: Fetching
    
    public func loadTop(list: TMDbToplist) {
        currentList = list
        fetchList(list, page: 1)
    }
    
    public func loadMore() {
        guard !isLoading else { return } // Check state
        guard let currentList = currentList else { return }
        guard let nextPage = resultsForCurrentList(currentList)?.nextPage else { return }
        fetchList(currentList, page: nextPage)
    }
    
    // MARK: API Calls
    
    private func fetchList(list: TMDbToplist, page: Int) {
        guard let currentList = currentList else { return }
        
        isLoading = true  // Update State

        movieClient.fetchToplist(list, page: page) { (response) in
            self.isLoading = false
            
            guard response.error == nil else {
                self.postErrorNotification(response.error!)
                return
            }
            
            if let newList = response.list, list = self.resultsForCurrentList(currentList) {
                self.updateList(list, withData: newList)
            }
        }
    }
    
    // MARK: Helpers
    
    private func resultsForCurrentList(list: TMDbToplist?) -> TMDbList<TMDbMovie>? {
        guard let list = currentList else { return nil }
        
        switch list {
        case .Popular:
            return popular
        case .TopRated:
            return topRated
        case .NowPlaying:
            return nowPlaying
        case .Upcoming:
            return upcoming
        }
    }

}







