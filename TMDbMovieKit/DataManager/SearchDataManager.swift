//
//  SearchDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 03-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class SearchDataManager: ListDataManager<Movie> {
    
    // MARK: - Initialize 
    
    public init() {
        super.init(refreshTimeOut: 0)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "search/movie"
    }
    
    // MARK: - Search
    
    fileprivate var searchQuery: String = ""
    
    public func search(for query: String) {
        searchQuery = query
        
        let delay = DispatchTime.now() + 0.25
        DispatchQueue.main.asyncAfter(deadline: delay) { 
            self.reloadIfNeeded(forceOnline: true, paramaters: ["query": self.searchQuery as AnyObject])
        }
    }
    
}
