//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public enum TMDbToplist: String {
    case Popular = "popular"
    case TopRated = "top_rated"
    case Upcoming = "upcoming"
    case NowPlaying = "now_playing"
}

public class TMDbTopListManager {
    
    // Public properties
    
    public var movies: [TMDbMovie] {
        guard let currentList = currentList else { return [] }
        
        switch currentList {
        case .Popular:
            return popular.items
        case .TopRated:
            return topRated.items
        case .Upcoming:
            return upcoming.items
        case .NowPlaying:
            return nowPlaying.items
        }
        
    }
    
    // Private properties
    
    private let movieService = TMDbMovieService()
    
    private var currentList: TMDbToplist?
    
    private var popular = TMDbListHolder<TMDbMovie>()
    
    private var topRated = TMDbListHolder<TMDbMovie>()
    
    private var upcoming = TMDbListHolder<TMDbMovie>()
    
    private var nowPlaying = TMDbListHolder<TMDbMovie>()
    
    // MARK: - Initialization 
    
    public init () { } // Singleton 
    
    // MARK: - Fetching

    public func reloadTopIfNeeded(forceOnline: Bool, list: TMDbToplist) {
        // For know I let NSURLCache handle the caching
        currentList = list
        fetchList(list, page: 1)
    }
    
    public func loadMore() {
        guard let list = currentList else { return }
        
        // Check which page we need to fetch
        var page: Int?
        
        switch list {
        case .Popular:
            page = popular.nextPage
        case .TopRated:
            page = topRated.nextPage
        case .NowPlaying:
            page = nowPlaying.nextPage
        case .Upcoming:
            page = upcoming.nextPage
        }
        
        fetchList(list, page: page)
    }
    
    // MARK: Fetching
    
    private func fetchList(list: TMDbToplist, page: Int?) {
        movieService.fetchTopList(list.rawValue, page: page, completionHandler: { (result, error) in
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            if let data = result {
                self.updateData(data)
            }
        })
    }
    
    // MARK: - Handle Response
    
    private func updateData(data: TMDbListHolder<TMDbMovie>) {
        guard let list = currentList else { return }
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { 
            switch list {
            case .Popular:
                self.popular.update(data)
            case .TopRated:
                self.topRated.update(data)
            case .Upcoming:
                self.upcoming.update(data)
            case .NowPlaying:
                self.nowPlaying.update(data)
            }
            
            dispatch_async(dispatch_get_main_queue(), { 
                let notification = NSNotification(name: TMDManagerDataDidChangeNotification, object: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
            })
            
        }
    }
    
    private func postErrorNotification(error: NSError) {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbManagerDidReceiveErrorNotification, object: nil, userInfo: ["error": error])
    }
    
}

    





