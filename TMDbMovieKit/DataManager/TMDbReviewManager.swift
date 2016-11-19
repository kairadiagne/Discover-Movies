//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbReviewManager: ListDataManager<Review> {
    
    // MARK: - Properties

    let movieID: Int
    
    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.movieID = movieID
        super.init(configuration: ReviewRequestConfiguration(movieID: movieID), refreshTimeOut: 0)
    }

}
