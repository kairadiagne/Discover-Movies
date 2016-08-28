//
//  TMDbTopListDataManagers.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

// MARK: TMDbTopListDataManager

public class TMDbTopListDataManager: TMDbListDataManager<Movie> {
    
    // MARK: - Initialize
    
    override init(list: TMDbListType, cacheIdentifier: String) {
        super.init(list: list, cacheIdentifier: cacheIdentifier)
    }
    
    // MARK: - Endpoint
    
    override func endpoint() -> String {
        return "movie/\(list.name)"
    }
    
}

// MARK: - Popular movies

public class TMDbPopularListManager: TMDbTopListDataManager {
    
    public static let shared = TMDbPopularListManager(list: TMDbTopList.Popular, cacheIdentifier: "Popular")
    
}

// MARK: - Toprated movies


public class TMDbTopRatedListManager: TMDbTopListDataManager {
    
    public static let shared = TMDbTopRatedListManager(list: TMDbTopList.TopRated, cacheIdentifier: "TopRated")
    
}

// MARK: - Upcoming movies

public class TMDbUpcomingListManager: TMDbTopListDataManager {
    
    public static let shared = TMDbTopRatedListManager(list: TMDbTopList.Upcoming, cacheIdentifier: "Upcoming")
    
}

// MARK: - Movies now playing

public class TMDbNowPlayingListManager: TMDbTopListDataManager {
    
    public static let shared = TMDbNowPlayingListManager(list: TMDbTopList.NowPlaying, cacheIdentifier: "NowPlaying")
}