//
//  ListDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public class ListDataManager<T: Codable >: DataManager<List<T>> {
    
    // MARK: - Properties
    
    public var allItems: [T] {
        return cachedData.data?.items ?? []
    }

    var currentPage: Int = 1

    // MARK: - Calls

    override public func reloadIfNeeded(forceOnline: Bool) {
        guard cachedData.needsRefresh || forceOnline else { return }
        currentPage = 0
        loadOnline()
    }

    public func loadMore() {
        guard isLoading == false else { return }
        guard let nextPage = cachedData.data?.nextPage else { return }
        currentPage = nextPage
        loadOnline()
    }

    // MARK: - Response
    
    override func handle(data: List<T>) {
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
