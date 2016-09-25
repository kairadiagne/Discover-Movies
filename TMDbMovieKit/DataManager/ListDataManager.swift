//
//  ListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class ListDataManager<ItemType: DictionaryRepresentable>: DataManager<List<ItemType>> {
    
    // MARK: - Properties
    
    public var allItems: [ItemType] {
        return cachedData.data?.items ?? []
    }
    
    // MARK: - Initialize
    
    init(refreshTimeOut: TimeInterval, cacheIdentifier: String? = nil, errorHandler: ErrorHandling = APIErrorHandler()) {
        super.init(errorHandler: errorHandler, refreshTimeOut: refreshTimeOut, cacheIdentifier: cacheIdentifier)
    }
    
    // MARK: - Calls 
    
    public func loadMore() {
        guard isLoading == false else { return }
        guard let nextPage = cachedData.data?.nextPage else { return }
        loadOnline(paramaters: paramaters, page: nextPage)
    }
    
    // MARK: - ResponseHandling
    
    override func handle(data: List<ItemType>) {
        if data.page == 1 {
            cachedData.clear()
            cachedData.add(data)
        } else {
            cachedData.data?.update(withNetxPage: data.page, pageCount: data.pageCount, resultCount: data.resultCount , items: data.items)
        }
        
        postUpdateNofitication()
    }

}


