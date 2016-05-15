//
//  TMDbMovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct Keys {
    static let Cast = "cast"
    static let Character = "character"
    static let CreditID = "id"
    static let Name = "name"
    static let Order = "order"
    static let ProfilePath = "profile_path"
    static let Crew = "crew"
    static let Directing = "Director"
}

public struct TMDbMovieCredit: JSONSerializable, Equatable {
    public var creditID: Int?
    public var cast: [TMDbCastMember] = []
    public var crew: [TMDbCrewMember] = []
    public var director: TMDbCrewMember?
    
    public init?(json: SwiftyJSON.JSON) {
        self.creditID = json[Keys.CreditID].int
        self.cast = json[Keys.Cast].flatMap { return TMDbCastMember(json: $0.1) }
        self.crew = json[Keys.Crew].flatMap { return TMDbCrewMember(json: $0.1) }
        
        // Filter out the director from the crew members
        let filteredCrew = crew.filter { return $0.job == Keys.Directing }
        self.director = filteredCrew.first ?? nil
    }
    
}

public func ==(rhs: TMDbMovieCredit, lhs: TMDbMovieCredit) -> Bool {
    return rhs.creditID == lhs.creditID
}





