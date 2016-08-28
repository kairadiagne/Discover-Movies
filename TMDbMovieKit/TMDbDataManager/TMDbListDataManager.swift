//
//  DataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbListDataManager<ItemType: DictionaryRepresentable>: TMDbDataManager<List<ItemType>> {
    
    // MARK: Properties
    
    public var itemsInList: [ItemType] {
        return cache.data?.items ?? []
    }
    
    let list: TMDbListType
    
    // MARK: Initialize
    
    init(list: TMDbListType, cacheIdentifier: String) {
        self.list = list
        super.init(cacheIdentifier: cacheIdentifier)
    }
    
    // MARK: Calls 
    
    override public func loadMore() {
        super.loadMore()
        guard let nextpage = cache.data?.nextPage else { return }
        loadOnline(paramaters, page: nextpage)
    }

    // MARK: Handle Response
    
    override func handleData(data: List<ItemType>) {
        if cache.data == nil {
            cache.addData(List<ItemType>())
        }
        
        cache.data?.page = data.page
        cache.data?.pageCount = data.pageCount
        cache.data?.resultCount = data.resultCount
        
        if data.page == 1 {
            cache.data?.items = data.items
            postDidLoadNotification()
        } else {
            cache.data?.items.appendContentsOf(data.items)
            postDidUpdateNotification()
        }
    }
    
}






