//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

open class TMDbReviewManager: PagingDataManager<Review> {
    
    // MARK: - Properties

    let movieID: Int
    
    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.movieID = movieID
        super.init(identifier: "", sessionInfoProvider: TMDbSessionInfoStore(), writesToDisk: true, refreshTimeOut: 300)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "movie/\(movieID)/reviews"
    }

}
