//
//  MovieInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieInfo: DictionaryRepresentable {
    
    // MARK: Properties
    
    public private(set) var similar: List<Movie>?
    public private(set) var credits: MovieCredit?
    public private(set) var trailers: [Video]?
    
    // MARK: Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        self.similar = dict["similar"] as? List<Movie>
        self.credits = dict["credits"] as? MovieCredit
       
        if let videoDicts = dict["trailers"]?["youtube"] as? [[String: AnyObject]] {
            for dict in videoDicts {
                if let video = Video(dictionary: dict) {
                    self.trailers?.append(video)
                }
            }
        }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }
    
    // MARK: Utils
    
    public func similarMovies() -> [Movie] {
        return similar?.items ?? []
    }
   
    public func cast() -> [CastMember] {
        return credits?.cast ?? []
    }

    public func director() -> CrewMember? {
        return credits?.director
    }

    public func trailer() -> Video? {
        return trailers?.first
    }
    
}
