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
    static let trailers = "trailers"
}

public class TMDbMovieInfo: NSObject, Mappable {
    
    var similarMovies: TMDbList<TMDbMovie>?
    public var credits: TMDbMovieCredit?
    public var trailers: [TMDbVideo]?
    
    public required init?(_ map: Map) { }
    
    public func mapping(map: Map) {
        self.similarMovies  <- map[Keys.Similar]
        self.credits        <- map[Keys.Credits]
        self.trailers       <- map[Keys.trailers]
    }
    
}