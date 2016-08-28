//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbReviewManager: TMDbListDataManager<Review> {
    
    // MARK: Properties
    
    static public let shared = TMDbReviewManager(list: TMDbOtherList.Reviews, cacheIdentifier: "Reviews")

    public var movieID: Int = 0
    
    // MARK: - Initialize
    
    override init(list: TMDbListType, cacheIdentifier: String) {
        super.init(list: list, cacheIdentifier: cacheIdentifier)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "movie/\(movieID)/reviews"
    }

}
