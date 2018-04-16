//
//  ListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class ListDataManager<ItemType: DictionarySerializable>: DataManager<List<ItemType>> {
    
    // MARK: - Properties
    
    public var allItems: [ItemType] {
        return cachedData.data?.items ?? []
    }
    
    // MARK: - Initialize
    
    override init(configuration: RequestConfiguration, refreshTimeOut: TimeInterval, cacheIdentifier: String? = nil) {
        super.init(configuration: configuration, refreshTimeOut: refreshTimeOut, cacheIdentifier: cacheIdentifier)
    }
    
    // MARK: - Calls 
    
    public func loadMore() {
        guard isLoading == false else { return }
        guard let nextPage = cachedData.data?.nextPage else { return }
        loadOnline(paramaters: cachedParams, page: nextPage)
    }
    
    // MARK: - Response
    
    override func handle(data: List<ItemType>) {
        if data.page == 0 {
            print("Page 0 so page is empty")
        } else if data.page == 1 {
            cachedData.data = data
        } else {
            cachedData.data?.update(withNetxPage: data.page, pageCount: data.pageCount, resultCount: data.resultCount, items: data.items)
        }
    
        postUpdateNofitication()
    }
}
