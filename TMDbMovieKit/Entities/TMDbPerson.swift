//
//  TMDbPerson.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct TMDbPerson: ResponseJSONObjectSerializable, Equatable {
    public var name: String?
    public var personID: Int?
    public var popularity: Int?
    public var profilePath: String?
    public var adult: Bool?
    public var movies: [TMDbMovie] = []
    
    public init?(json: SwiftyJSON.JSON) {
        self.name = json["name"].string
        self.personID = json["id"].int
        self.popularity = json["popularity"].int
        self.profilePath = json["profile_path"].string
        self.adult = json["adult"].bool
        let movies: [TMDbMovie?] = json["know_for"].map { return $0.1["media_type"] == "movie" ? TMDbMovie(json: json): nil }
        self.movies = movies.flatMap { return $0 }
    }
    
}

public func ==(lhs: TMDbPerson, rhs: TMDbPerson) -> Bool {
    if lhs.name != rhs.name { return false }
    if lhs.personID != rhs.personID { return false }
    if lhs.popularity != rhs.popularity { return false }
    if lhs.profilePath != rhs.profilePath { return false }
    if lhs.adult != rhs.adult { return false }
    if lhs.movies   != rhs.movies { return false }
    return true
}
