//
//  TMDbReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class TMDbReviewManager: ListDataManager<Review> {
    
    // MARK: - Properties

    let movieID: Int
    
    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.movieID = movieID
        super.init(request: ApiRequest.review(movieID: movieID), refreshTimeOut: 0)
    }
}
