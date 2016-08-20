//
//  TMDbUpcomingListManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbUpcomingListManager: TMDbTopListManager {
    
    public static let shared = TMDbPopularListManager(cacheIdentifier: "UpcomingMovies", topList: TMDbToplist.Upcoming)
    
}