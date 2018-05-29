//
//  SimilarMoviesDataManager.swift
//  Discover
//
//  Created by Kaira Diagne on 13-11-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class SimilarMoviesDataManager: ListDataManager<Movie> {
    
    // MARK: - Properties
    
    let movieID: Int
    
    public var firstPage: [Movie] {
        return allItems.prefix(20) + []
    }
    
    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.movieID = movieID
        super.init()
    }

    // MARK: - Calls

    override func loadOnline() {
        let requestBuilder = RequestBuilder.similarMovies(movieID: movieID, page: currentPage)
        makeRequest(builder: requestBuilder)
    }
}
