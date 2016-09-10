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
    
    private var pages: [Page<ItemType>] = []
    
    // MARK: - Initialize
    
    override init(identifier: String, errorHandler: ErrorHandling = APIErrorHandler(), sessionInfoProvider: SessionInfoContaining, writesToDisk: Bool, refreshTimeOut: NSTimeInterval) {
        super.init(identifier: identifier, errorHandler: errorHandler, sessionInfoProvider: sessionInfoProvider, writesToDisk: writesToDisk, refreshTimeOut: refreshTimeOut)
    }
    
    // MARK: - Calls 
    
    public func loadMore() {
        guard isLoading == false, let lastFetchedPage = pages.last, let nextPage = lastFetchedPage.nextPage else { return }
        loadOnline(paramaters: paramaters, page: nextPage)
    }
    
    // MARK: - ResponseHandling
    
    override func handleData(data: Page<ItemType>) {
        if data.page == 1 {
            pages = []
        }
        
        pages.append(data)
        
        postDidLoadNotification()
    }

    // MARK: - Items 
    
    func itemsInList() -> [ItemType] {
        return pages.reduce([], combine: { $0 + $1.items })
    }
    
}


