//
//  Directory.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 06-06-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

enum Directory {
    case Popular
    case TopRated
    case Upcoming
    case NowPlaying
    case Favorites
    case Watchlist
    
    var archiveURL: NSURL {
        let cachesDirectory = NSFileManager().URLsForDirectory(.CachesDirectory, inDomains: .UserDomainMask).first!
        
        switch self {
        case .Popular:
            return cachesDirectory.URLByAppendingPathComponent("popular.dat")
        case .TopRated:
            return cachesDirectory.URLByAppendingPathComponent("toprated.dat")
        case .Upcoming:
            return cachesDirectory.URLByAppendingPathComponent("upcoming.dat")
        case .NowPlaying:
            return cachesDirectory.URLByAppendingPathComponent("nowplaying.dat")
        case .Favorites:
            return cachesDirectory.URLByAppendingPathComponent("favorites.dat")
        case .Watchlist:
            return cachesDirectory.URLByAppendingPathComponent("watchlist.dat")
        }
    }
    
}