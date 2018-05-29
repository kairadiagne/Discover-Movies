//
//  ReviewManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class ReviewManager: ListDataManager<Review> {
    
    // MARK: - Properties

    let movieID: Int
    
    // MARK: - Init
    
    public init(movieID: Int) {
        self.movieID = movieID
        super.init()
    }

    // MARK: - Calls

    override func loadOnline() {
        let requestBuilder = RequestBuilder.reviews(movieID: movieID, page: currentPage)
        makeRequest(builder: requestBuilder)
    }
}
