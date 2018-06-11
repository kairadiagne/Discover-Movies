//
//  TopListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TopListDataManager: ListDataManager<Movie> {
    
    private let list: TMDbTopList
    
    // MARK: - Initialize
    
    public init(list: TMDbTopList) {
        self.list = list
        super.init(refreshTimeOut: 3600, cacheIdentifier: list.name)
    }

    // MARK: - Calls

    override func loadOnline() {
        let requestBuilder = RequestBuilder.topList(list: list, page: currentPage)
        makeRequest(builder: requestBuilder)
    }
    
    override func handle(data: List<Movie>) {
        if data.page == 1 {
            cachedData.data = data
        } else {
            cachedData.data?.update(withNetxPage: data.page, pageCount: data.totalPages, resultCount: data.totalResults, items: data.results)
        }
        
        postUpdateNofitication()
    }
}
