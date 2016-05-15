//
//  TMDbMovie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct Keys {
    static let MovieID = "id"
    static let Title = "title"
    static let ReleaseDate = "release_date"
    static let GenreID = "genre_ids"
    static let GenreString = "genre_strings"
    static let Overview = "overview"
    static let VoteAverage = "vote_average"
    static let Adult = "adult"
    static let Popularity = "popularity"
    static let PosterPath = "poster_path"
    static let BackdropPath = "backdrop_path"
}

public struct TMDbMovie: JSONSerializable, Equatable {
    public var movieID: Int?
    public var title: String?
    public var releaseDate: NSDate?
    public var genreIDs: [Int]
    public var genreStrings: [String] = []
    public var overview: String?
    public var rating: Double?
    public var adult: Bool?
    public var popularity: Int?
    public var posterPath: String?
    public var backDropPath: String?
    
    
    public init?(json: SwiftyJSON.JSON) {
        self.movieID = json[Keys.MovieID].int
        self.title = json[Keys.Title].string
        self.releaseDate = json[Keys.ReleaseDate].string?.toDate()
        self.genreIDs = json[Keys.GenreID].arrayValue.flatMap { $0.int }
        self.overview = json[Keys.Overview].string
        self.rating = json[Keys.VoteAverage].double
        self.adult = json[Keys.Adult].bool
        self.popularity = json[Keys.Popularity].int
        self.posterPath = json[Keys.PosterPath].string
        self.backDropPath = json[Keys.BackdropPath].string
        
        // Convert genre id's to array of strings
        self.genreStrings = genreIDs.map { return TMDbGenres.genreWithID($0)?.name }.flatMap { $0 }
    }
    
}

public func ==(lhs: TMDbMovie, rhs: TMDbMovie) -> Bool {
    return lhs.movieID == rhs.movieID
}

