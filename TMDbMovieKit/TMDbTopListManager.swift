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

// MARK: - Notifications 

// These notifications can be generic for all Data managers as long as the controller knows which object to listen to
public let TMDbTopListManagerDidChangeNotification = "TMDbTopListManagerDidChangeNotification"
public let TMDbTopListManagerDidReceiveErrorNotification = "TMDbTopListManagerDidReceiveErrorNotification"
// TMDbTopListManagerIsUptoDateNotification ????? 

// TODO - Refractor 

public class TMDbTopListManager {
    
    // MARK: - Properties
    
    // Public
    
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
    
    // Private
    
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
                let notification = NSNotification(name: TMDbTopListManagerDidReceiveErrorNotification, object: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
                return
            }
            
            if let data = result {
                self.updateData(data)
            }
        })
    }
    
    // MARK: - Update data 
    
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
                let notification = NSNotification(name: TMDbTopListManagerDidChangeNotification, object: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
            })
            
        }
        
        
        
    }
    
}

    





