//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbReviewManager: TMDbListDataManager<Review> {
    
    // MARK: - Properties
    
    static public let shared = TMDbReviewManager(list: TMDbOtherList.Reviews, cacheIdentifier: "Reviews")

    public var movieID: Int = 0
    
    // MARK: - Initialize
    
    private init(list: TMDbListType, cacheIdentifier: String) {
        super.init(list: list, cacheIdentifier: cacheIdentifier, writesDataToDisk: false, refreshTimeOut: 300)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "movie/\(movieID)/reviews"
    }

}
