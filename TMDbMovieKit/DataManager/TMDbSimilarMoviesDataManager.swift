//
//  TMDbSimilarMoviesDataManager.swift
//  Discover
//
//  Created by Kaira Diagne on 13-11-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbSimilarMoviesDataManager: ListDataManager<Movie> {
    
    // MARK: - Properties
    
    let movieID: Int
    
    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.movieID = movieID
        super.init(refreshTimeOut: 0)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "movie/\(movieID)/similar"
    }
    
}
