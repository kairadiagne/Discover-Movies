//
//  TMDbPerson.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

//// TODO: - Change this class so it can be initialized with json data from the movie credit json
//private struct Keys {
//    static let PersonID = "id"
//    static let Name = "name"
//    static let Popularity = "popularity"
//    static let ProfilePath = "profile_path"
//    static let Adult = "adult"
//    static let KnownFor = "know_for"
//    static let MediaType = "media_type"
//    static let Movies = "movie"
//    static let Job = "job"
//}
//
//public class TMDbPerson: JSONSerializable {
//    public var personID: Int?
//    public var job: String?
//    public var name: String?
//    public var popularity: Int?
//    public var profilePath: String?
//    public var adult: Bool?
//    public var movies: [TMDbMovie] = []
//    
//    public required init?(json: SwiftyJSON.JSON) {
//        self.personID = json[Keys.PersonID].int
//        self.job = json[Keys.Job].string
//        self.name = json[Keys.Name].string
//        self.popularity = json[Keys.Popularity].int
//        self.profilePath = json[Keys.Popularity].string
//        self.adult = json[Keys.Adult].bool
//        
//        let movies: [TMDbMovie?] = json[Keys.KnownFor].map {
//            return $0.1[Keys.MediaType] == "movie" ? TMDbMovie(json: json): nil
//        }
//        
//        self.movies = movies.flatMap { return $0 }
//    }
//    
//}
//
//public func ==(lhs: TMDbPerson, rhs: TMDbPerson) -> Bool {
//    return lhs.personID == rhs.personID
//}




