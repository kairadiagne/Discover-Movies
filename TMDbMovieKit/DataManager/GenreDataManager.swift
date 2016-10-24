//
//  GenreDataManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class GenreDataManager: ListDataManager<Movie> {
    
    // MARK: - Initialize
    
    public init() {
       super.init(refreshTimeOut: 600)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "discover/movie"
    }

}
