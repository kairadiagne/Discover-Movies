//
//  TMDbMovie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct TMDbMovie: ResponseJSONObjectSerializable, Equatable {
    public var movieID: Int?
    public var title: String?
    public var releaseDate: NSDate?
    public var genreIDs: [Int]
    public var genreStrings: [String]
    public var overview: String?
    public var rating: Double?
    public var adult: Bool?
    public var popularity: Int?
    public var posterPath: String?
    public var backDropPath: String?
    
    public init?(json: SwiftyJSON.JSON) {
        self.movieID = json["id"].int
        self.title = json["title"].string
        self.releaseDate = json["release_date"].string?.toDate()
        self.genreIDs = json["genre_ids"].arrayValue.flatMap { $0.int }
        self.genreStrings = genreIDs.map { return TMDbGenres.genreWithID($0)?.name }.flatMap { $0 }
        self.overview = json["overview"].string
        self.rating = json["vote_average"].double
        self.adult = json["adult"].bool
        self.popularity = json["popularity"].int
        self.posterPath = json["poster_path"].string
        self.backDropPath = json["backdrop_path"].string
    }
    
}

public func ==(lhs: TMDbMovie, rhs: TMDbMovie) -> Bool {
    if lhs.movieID != rhs.movieID { return false }
    if lhs.title != rhs.title { return false }
    if lhs.releaseDate != rhs.releaseDate { return false }
    if lhs.genreIDs != rhs.genreIDs { return false }
    if lhs.genreStrings != rhs.genreStrings { return false }
    if lhs.overview != rhs.overview { return false }
    if lhs.rating != rhs.rating { return false }
    if lhs.adult != rhs.adult { return false }
    if lhs.popularity != rhs.popularity { return false }
    if lhs.posterPath != rhs.posterPath { return false }
    if lhs.backDropPath != rhs.backDropPath { return false }
    return true
}
