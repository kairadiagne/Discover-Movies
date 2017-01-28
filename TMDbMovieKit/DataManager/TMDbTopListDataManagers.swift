//
//  TMDbTopListDataManagers.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbTopListDataManager: ListDataManager<Movie> {
    
    let list: TMDbList
    
    // MARK: - Initialize
    
    public init(list: TMDbTopList) {
        self.list = list
        super.init(configuration: TopListRequestConfiguration(list: list), refreshTimeOut: 3600, cacheIdentifier: list.name)
        
    }
    
    override func handle(data: List<Movie>) {
        if data.page == 1 {
            cachedData.data = data
        } else {
            cachedData.data?.update(withNetxPage: data.page, pageCount: data.pageCount, resultCount: data.resultCount , items: data.items)
        }
        
        postUpdateNofitication()
    }
    
}

