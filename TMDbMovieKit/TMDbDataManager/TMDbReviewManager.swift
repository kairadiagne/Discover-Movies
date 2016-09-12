//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbReviewManager: PagingDataManager<Review> {
    
    // MARK: - Properties

    let movieID: Int
    
    let sessionInfoProvider: SessionInfoContaining
    
    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.movieID = movieID
        self.sessionInfoProvider = TMDbSessionInfoStore()
        super.init(refreshTimeOut: 300)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "movie/\(movieID)/reviews"
    }

}
