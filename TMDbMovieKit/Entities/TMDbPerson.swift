//
//  TMDbPerson.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct Keys {
    static let PersonID = "id"
    static let Name = "name"
    static let Popularity = "popularity"
    static let ProfilePath = "profile_path"
    static let Adult = "adult"
    static let KnownFor = "know_for"
    static let MediaType = "media_type"
    static let Movies = "movie"
}

public class TMDbPerson: JSONSerializable {
    public var personID: Int?
    public var name: String?
    public var popularity: Int?
    public var profilePath: String?
    public var adult: Bool?
    public var movies: [TMDbMovie] = []
    
    public required init?(json: SwiftyJSON.JSON) {
        self.personID = json["id"].int
        self.name = json["name"].string
        self.popularity = json["popularity"].int
        self.profilePath = json["profile_path"].string
        self.adult = json["adult"].bool
        let movies: [TMDbMovie?] = json["know_for"].map { return $0.1["media_type"] == "movie" ? TMDbMovie(json: json): nil }
        self.movies = movies.flatMap { return $0 }
    }
    
}

public func ==(lhs: TMDbPerson, rhs: TMDbPerson) -> Bool {
    return lhs.personID == rhs.personID
}
