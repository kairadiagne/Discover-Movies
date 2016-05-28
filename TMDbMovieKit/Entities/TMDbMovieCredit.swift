//
//  TMDbMovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

private struct Keys {
    static let Cast = "cast"
    static let Character = "character"
    static let CreditID = "id"
    static let Name = "name"
    static let Order = "order"
    static let ProfilePath = "profile_path"
    static let Crew = "crew"
    static let Director = "Director"
}

public class TMDbMovieCredit: NSObject, Mappable {
    
    public var cast: [TMDbCastMember] = []
    public var crew: [TMDbCrewMember] = []
    public var director: TMDbCrewMember?
    
    public required init?(_ map: Map) { }
    
    public func mapping(map: Map) {
        self.cast       <- map[Keys.Cast]
        self.crew       <- map[Keys.Crew]
        
        // Grab the director from the crew array
        self.director = crew.filter { return $0.job == Keys.Director }.first ?? nil
    }
    
}




