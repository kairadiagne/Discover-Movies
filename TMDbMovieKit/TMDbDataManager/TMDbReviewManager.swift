//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbReviewManager: TMDbDataManager<List<Review>> {
    
    // MARK: Properties
    
    static public let shared = TMDbReviewManager(cacheIdentifier: "Reviews")
    
    public var movieID: Int = 0
    
    public var itemsInList: [Review] {
        return cache.data?.items ?? []
    }
    
    override var endpoint: String {
        return "movie/\(movieID)/reviews"
    }

    // MARK: Initialize
    
    override init(cacheIdentifier: String = "") {
        super.init(cacheIdentifier: cacheIdentifier)
    }
    
    // MARK: Calls
    
    override public func loadMore() {
        super.loadMore()
        guard cache.data?.nextPage != nil else { return }
        let paramaters = getParameters()
        loadOnline(paramaters, endpoint: endpoint)
    }
    
    // MARK: Paramaters
    
    override func getParameters() -> [String : AnyObject] {
        guard let nextPage = cache.data?.nextPage else { return [:] }
        return ["page": nextPage]
    }
    
    // MARK: Handle Response
    
    override func handleData(data: List<Review>) {
        if cache.data == nil {
            cache.addData(List<Review>())
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

