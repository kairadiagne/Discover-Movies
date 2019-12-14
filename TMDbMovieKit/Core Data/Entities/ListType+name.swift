//
//  ListType+name.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 06/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

extension List.ListType {

    var name: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        case .nowPlaying:
            return "now_playing"
        case .favorite:
            return "favorite"
        case .watchlist:
            return "watchlist"
        }
    }
}
