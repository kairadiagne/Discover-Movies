//
//  TMDbMovieTopList.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public enum TMDbToplist: CustomStringConvertible {
    case Popular
    case TopRated
    case Upcoming
    
    public var description: String {
        switch self {
        case .Popular:
            return "popular"
        case .TopRated:
            return "top_rated"
        case .Upcoming:
            return "upcoming"
        }
    }
}