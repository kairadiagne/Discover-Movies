//
//  TMDbTopListDataManagers.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbTopListDataManager: PagingDataManager<Movie> {
    
    // MARK: - Properties
    
    let list: TMDbListType
    
    // MARK: - Initialize
    
    init(list: TMDbListType) {
        self.list = list
        super.init(identifier: list.name, sessionInfoProvider: TMDbSessionInfoStore(), writesToDisk: true, refreshTimeOut: 3600)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "movie/\(list.name)"
    }
    
}
