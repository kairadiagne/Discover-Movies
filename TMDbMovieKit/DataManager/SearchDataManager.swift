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
    
    public func search(for query: String) {
        reloadIfNeeded(forceOnline: true, paramaters: ["query": query as AnyObject])
    }
    
    // MARK: - Default Paramaters
    
    override func defaultParamaters() -> [String : AnyObject] {
        return ["include_adult" : false as AnyObject]
    }
    
}

