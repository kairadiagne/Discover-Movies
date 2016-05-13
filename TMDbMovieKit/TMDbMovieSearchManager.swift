//
//  TMDbDiscoverManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

public enum TMDbSearchType {
    case SearchByTitle(title: String)
    case Discover(year: String, genre: Int, vote: Float)
}

import Foundation

public class TMDbMovieSearchManager {
    
    public init() { }
    
    public var searchResults: [TMDbMovie] {
        return search.items
    }
    
    private let movieService = TMDbMovieService()
    
    private var currentSearch: TMDbSearchType?
    
    private var search = TMDbListHolder<TMDbMovie>()
    
    // MARK: - Fetching 
    
    public func reloadIfNeeded(forceOnline: Bool, search: TMDbSearchType) {
        currentSearch = search
        
        switch search {
        case .SearchByTitle(let title):
            searchByTitle(title, page: 1)
        case .Discover(let year, let genre, let vote):
            discover(year, genre: genre, vote: vote, page: 1)
        }
    }
    
    public func loadMore() {
        guard let currentSearch = currentSearch else { return }
        switch currentSearch {
            case .SearchByTitle(let title):
                searchByTitle(title, page: search.nextPage)
            case .Discover(let year, let genre, let vote):
                discover(year, genre: genre, vote: vote, page: search.nextPage)
        }
    }
    
    private func searchByTitle(title: String, page: Int?) {
        movieService.searchForMovieWith(title, page: page) { (result, error) in
            guard error != nil else {
                self.postErrorNotification(error!)
                return
            }
            
            if let data = result {
                self.updateData(data)
            }
        }
    }
    
    private func discover(year: String?, genre: Int?, vote: Float?, page: Int?) {
        movieService.discoverMovies(year, genre: genre, vote: vote, page: page) { (result, error) in
            guard error != nil else {
                self.postErrorNotification(error!)
                return
            }
            
            if let data = result {
                self.updateData(data)
            }
        }
    }
    
    // MARK: - Handle Response 
    
    private func updateData(data: TMDbListHolder<TMDbMovie>) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { 
            self.search.update(data)
            
            dispatch_async(dispatch_get_main_queue(), { 
                let notification = NSNotification(name: TMDbManagerIsUpToDateNotification, object: nil)
                NSNotificationCenter.defaultCenter().postNotification(notification)
            })
        }
        
    }
    
    private func postErrorNotification(error: NSError) {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbManagerDidReceiveErrorNotification, object: nil, userInfo: ["error": error])
    }
    
}