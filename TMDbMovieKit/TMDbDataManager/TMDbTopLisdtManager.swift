//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

// Here we can use a proxy class that has three managers in cache (first memory cahce later disk cache (For every toplist)

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
    
    // MARK: Request Data

    public func loadTop(list: TMDbToplist) {
        currentList = list
        fetchList(list, page: 1)
    }
    
    public func loadMore() {
        guard state != .Loading else { return }
        guard let currentList = currentList else { return }
        guard let nextPage = resultsForCurrentList(currentList)?.nextPage else { return }
        fetchList(currentList, page: nextPage)
    }
    
    // MARK: API Calls
    
    private func fetchList(list: TMDbToplist, page: Int) {
        guard let currentList = currentList else { return }
        
        state = .Loading

        movieClient.fetchToplist(list, page: page) { (response) in

            guard response.error == nil else {
                self.handleError(response.error!)
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







