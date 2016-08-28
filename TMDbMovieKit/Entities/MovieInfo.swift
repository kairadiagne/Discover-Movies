//
//  MovieInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieInfo: DictionaryRepresentable {
    
    // MARK: - Properties
    
    public private(set) var similar: List<Movie>?
    public private(set) var credits: MovieCredit?
    public private(set) var trailers: [Video]?
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        if let similarMovieDict = dict["similar"] as? [String: AnyObject] {
            self.similar = List<Movie>(dictionary: similarMovieDict)
        }
        if let creditDict = dict["credits"] as? [String: AnyObject] {
            self.credits = MovieCredit(dictionary: creditDict)
        }
    
        if let videoDicts = dict["trailers"]?["youtube"] as? [[String: AnyObject]] {
            var trailers = [Video]()
            for dict in videoDicts {
                if let video = Video(dictionary: dict) {
                    trailers.append(video)
                    self.trailers = trailers
                }
            }
        }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        // No need to archive MovieIfo
        return [:]
    }
    
    // MARK: - Utils
    
    public func similarMovies() -> [Movie] {
        return similar?.items ?? []
    }
   
    public func cast() -> [CastMember] {
        return credits?.cast ?? []
    }

    public func director() -> CrewMember? {
        return credits?.crew.filter { return $0.job == "Director" }.first ?? nil
    }

    public func trailer() -> Video? {
        return trailers?.first
    }
    
}
