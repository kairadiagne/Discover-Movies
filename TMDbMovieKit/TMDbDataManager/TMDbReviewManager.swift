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
    
    let movieID: Int
    
    override var endpoint: String {
        return "movie/\(movieID)/reviews"
    }
    
    // MARK: Initialization
    
    init(movieID: Int, cacheIdentifier: String = "") {
        self.movieID = movieID
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
//        data.update(data.page, pageCount: data.pageCount, resultCount: data.resultCount, items: data.items)
        cache.addData(data)
        saveToDisk()
    }
    
}

