//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class TMDbTopListManager: TMDbDataManager {
    
    // MARK: Properties
    
    public var inProgress = false
    
    public var movies: [TMDbMovie] {
        guard let results = resultsForCurrentList(currentList) else { return [] }
        return results.items
    }
    
    private var currentList: TMDbToplist?

    private let movieClient = TMDbMovieClient()
    
    private let cache = TMDbCache<TMDbList<TMDbMovie>>()
    
    private var popular = TMDbList<TMDbMovie>()
    
    private var topRated = TMDbList<TMDbMovie>()
    
    private var upcoming = TMDbList<TMDbMovie>()
    
    private var nowPlaying = TMDbList<TMDbMovie>()
    
    // MARK: Initializers
    
    public init() { }
    
    // MARK: Fetching
    
    public func reloadTopIfNeeded(forceOnline: Bool, list: TMDbToplist) {
        currentList = list
        inProgress = true
        fetchList(list, page: 1)
    }
    
    public func loadMore() {
        guard inProgress == false else { return }
        guard let currentList = currentList else { return }
        guard let listData = resultsForCurrentList(currentList) else { return }
        
        fetchList(currentList, page: listData.nextPage ?? 1)
    }
    
    // MARK: Fetching
    
    private func fetchList(list: TMDbToplist, page: Int) {
        guard let currentList = currentList else { return }
        
        cache.loadDataFromCache(directoryForCurrentList(list)) { (data) in
            if let list = data  {
                print(list)
            }
        }
        
        inProgress = true
        
        movieClient.fetchToplist(list, page: page) { (response) in
            self.inProgress = false
            
            guard response.error == nil else {
                self.postErrorNotification(response.error!)
                return
            }
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { 
                if let newlist = response.value, list = self.resultsForCurrentList(currentList) {
                    list.update(newlist)
                    self.cache.cacheData(list, directory: self.directoryForCurrentList(currentList))
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        if list.page == 1 {
                            self.postUpdateNotification()
                        } else if list.page > 1 {
                            self.postChangeNotification()
                        }
                    })
                }
            })
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
    
    private func directoryForCurrentList(list: TMDbToplist) -> Directory {
        
        switch list {
        case .Popular:
            return Directory.Popular
        case .TopRated:
            return Directory.TopRated
        case .NowPlaying:
            return Directory.NowPlaying
        case .Upcoming:
            return Directory.Upcoming
        }
    }
 
}







