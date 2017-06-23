//
//  MovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieInfo {
    public let movie: Movie
    public internal(set) var trailers: [Video] = []
    public internal(set) var cast: [CastMember] = []
    public internal(set) var crew: [CrewMember] = []
    
    public var trailer: Video? {
        return trailers.filter { $0.type == "Trailer" }.first
    }
    
    public var director: CrewMember? {
        return crew.filter { return $0.job == "Director" }.first ?? nil
    }
}

extension MovieInfo: DictionarySerializable {
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let movie = Movie(dictionary: dict),
        let creditsDict = dict["credits"] as? [String: AnyObject],
            let castDicts = creditsDict["cast"] as? [[String: AnyObject]],
            let crewDicts = creditsDict["crew"] as? [[String: AnyObject]] else {
                return nil
        }
        
        self.movie = movie
        self.cast = castDicts.map { return CastMember(dictionary: $0) }.flatMap { $0 }
        self.crew = crewDicts.map { return CrewMember(dictionary: $0) }.flatMap { $0 }
        
        if let trailerDicts = dict["trailers"] as? [String: AnyObject], let youtube = trailerDicts["youtube"] as? [[String: AnyObject]] {
            self.trailers = youtube.flatMap { Video(dictionary: $0) }
        }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }
    
}
