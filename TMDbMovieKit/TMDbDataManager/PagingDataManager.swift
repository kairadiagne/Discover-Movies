//
//  PagingDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class PagingDataManager<ItemType: DictionaryRepresentable>: DataManager<Page<ItemType>> {
    
    // MARK: - Properties
    
    fileprivate var pages: [Page<ItemType>] = []
    
    // MARK: - Initialize
    
    init(identifier: String, writesToDisk: Bool, refreshTimeOut: TimeInterval, errorHandler: ErrorHandling = APIErrorHandler()) {
        super.init(identifier: identifier, errorHandler: errorHandler , writesToDisk: writesToDisk, refreshTimeOut: refreshTimeOut)
    }
    
    // MARK: - Calls 
    
    public func loadMore() {
        guard isLoading == false, let lastFetchedPage = pages.last, let nextPage = lastFetchedPage.nextPage else { return }
        loadOnline(paramaters: paramaters, page: nextPage)
    }
    
    // MARK: - ResponseHandling
    
    override func handle(data: Page<ItemType>) {
        if data.page == 1 {
            pages = []
        }
        
        pages.append(data)
        postDidLoadNotification()
    }

    // MARK: - Items 
    
    open func allItems() -> [ItemType] {
        return pages.reduce([], { $0 + $1.items })
    }
    
}


