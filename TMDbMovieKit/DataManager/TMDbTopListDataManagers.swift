//
//  TMDbTopListDataManagers.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbTopListDataManager: ListDataManager<Movie> {
    
    // MARK: - Properties
    
    let sessionInfoProvider: SessionInfoContaining
    
    let list: TMDbListType
    
    // MARK: - Initialize
    
    public init(list: TMDbTopList) {
        self.list = list
        self.sessionInfoProvider = TMDbSessionInfoStore()
        super.init(refreshTimeOut: 3600, cacheIdentifier: list.name)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "movie/\(list.name)"
    }
    
}
