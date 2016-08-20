//
//  TMDbMovieInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

private struct Keys {
    static let Similar = "similar"
    static let Credits = "credits"
    static let trailers = "trailers.youtube"
}

public class TMDbMovieInfo: Mappable {
    
    // MARK: Properties
    
//    var list: TMDbList<TMDbMovie>?
    public var credits: TMDbMovieCredit?
    public var trailers: [TMDbVideo]?
    
    // MARK: Initialization
    
    public required init?(_ map: Map) { }
    
    public func mapping(map: Map) {
//        self.list       <- map[Keys.Similar]
        self.credits    <- map[Keys.Credits]
        self.trailers   <- map[Keys.trailers]
    }
    
    // MARK: Utils 
    
    public func similarMovies() -> [TMDbMovie] {
//        return list?.items ?? []
        return []
    }
    
    public func cast() -> [TMDbCastMember] {
        return credits?.cast ?? []
    }
    
    public func director() -> TMDbCrewMember? {
        return credits?.director
    }
    
    public func trailer() -> TMDbVideo? {
        return trailers?.first
    }
    
}