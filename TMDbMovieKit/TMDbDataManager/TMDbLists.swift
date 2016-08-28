//
//  TMDbList.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol TMDbListType {
    var name: String { get }
}

public enum TMDbTopList: TMDbListType {
    case Popular
    case TopRated
    case Upcoming
    case NowPlaying
    
    public var name: String {
        switch self {
        case Popular:
            return "popular"
        case TopRated:
            return "top_rated"
        case Upcoming:
            return "upcoming"
        case NowPlaying:
            return "now_playing"
        }
    }
}

public enum TMDbAccountList: TMDbListType {
    case Favorite
    case Watchlist
    
    public var name: String {
        switch self {
        case Favorite:
            return "favorite"
        case Watchlist:
            return "watchlist"
        }
    }
    
}

public enum TMDbOtherList: TMDbListType {
    case Reviews
    
    public var name: String {
        switch self {
        case .Reviews:
            return "reviews"
        }
    }
}
