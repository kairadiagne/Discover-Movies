//
//  TMDbAccountState.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

private struct Keys {
    static let Favorite = "favorite"
    static let Watchlist = "watchlist"
}

public class TMDbAccountState: NSObject, Mappable {
    
    public var favoriteStatus: Bool = false
    public var watchlistStatus: Bool = false
    
    public required init?(_ map: Map) { }
    
    public func mapping(map: Map) {
        self.favoriteStatus   <- map[Keys.Favorite]
        self.watchlistStatus  <- map[Keys.Watchlist]
    }
    
}

