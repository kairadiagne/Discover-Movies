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
    
    fileprivate var similar: List<Movie>?
    fileprivate var credits: MovieCredit?
    fileprivate var trailers: [Video]?
    
    public var similarMovies: [Movie] {
        return similar?.items ?? []
    }
    
    public var cast: [CastMember] {
       return credits?.cast ?? []
    }
    
    public var director: CrewMember? {
        return credits?.crew.filter { return $0.job == "Director" }.first ?? nil
    }
    
    public var trailer: Video? {
        return trailers?.filter { $0.type == "Trailer" }.first
    }
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        if let similarMovieDict = dict["similar"] as? [String: AnyObject] {
            self.similar = List<Movie>(dictionary: similarMovieDict)
        }
        
        if let creditDict = dict["credits"] as? [String: AnyObject] {
            self.credits = MovieCredit(dictionary: creditDict)
        }
        
        if let videoDicts = dict["trailers"]?["youtube"] as? [[String: AnyObject]] {
            self.trailers = videoDicts.map { return Video(dictionary: $0) }.flatMap { $0 }
        }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        // No need to archive MovieIfo
        return [:]
    }
    
}

