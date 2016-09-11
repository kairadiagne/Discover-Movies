//
//  PagingDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

open class PagingDataManager<ItemType: DictionaryRepresentable>: DataManager<Page<ItemType>> {
    
    // MARK: - Properties
    
    fileprivate var pages: [Page<ItemType>] = []
    
    // MARK: - Initialize
    
    override init(identifier: String, errorHandler: ErrorHandling = APIErrorHandler(), sessionInfoProvider: SessionInfoContaining, writesToDisk: Bool, refreshTimeOut: TimeInterval) {
        super.init(identifier: identifier, errorHandler: errorHandler, sessionInfoProvider: sessionInfoProvider, writesToDisk: writesToDisk, refreshTimeOut: refreshTimeOut)
    }
    
    // MARK: - Calls 
    
    open func loadMore() {
        guard isLoading == false, let lastFetchedPage = pages.last, let nextPage = lastFetchedPage.nextPage else { return }
        loadOnline(paramaters: paramaters, page: nextPage)
    }
    
    // MARK: - ResponseHandling
    
    override func handleData(_ data: Page<ItemType>) {
        if data.page == 1 {
            pages = []
        }
        
        pages.append(data)
        
        postDidLoadNotification()
    }

    // MARK: - Items 
    
    open func itemsInList() -> [ItemType] {
        return pages.reduce([], { $0 + $1.items })
    }
    
}


