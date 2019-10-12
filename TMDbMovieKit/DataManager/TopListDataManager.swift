//
//  TopListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class TopListDataManager: ListDataManager<Movie> {
    
    let list: TMDbList
    
    // MARK: - Initialize
    
    public init(list: TMDbTopList) {
        self.list = list
        super.init(request: ApiRequest.topList(list: list), refreshTimeOut: 3600, cacheIdentifier: list.name)
        
    }
}
