//
//  TMDbDiscoverManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

public enum TMDbSearchType {
    case SearchByTitle(title: String)
    case Discover(year: String, genre: Int, vote: Float)
}

import Foundation

public class TMDbMovieSearchManager {
    
    public init() { }
    
    private let movieService = TMDbMovieService()
    
    // MARK: - Fetching 
    
    public func reloadIfNeeded(forceOnline: Bool, search: TMDbSearchType) {
        
    }
    
    public func loadMore() {
        
    }
    
}