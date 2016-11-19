//
//  TMDbList.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol TMDbList {
    var name: String { get }
}

public enum TMDbTopList: TMDbList {
    case popular
    case topRated
    case upcoming
    case nowPlaying
    
    public var name: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        case .nowPlaying:
            return "now_playing"
        }
    }
}

public enum TMDbAccountList: TMDbList {
    case favorite
    case watchlist
    
    public var name: String {
        switch self {
        case .favorite:
            return "favorite"
        case .watchlist:
            return "watchlist"
        }
    }
    
}
