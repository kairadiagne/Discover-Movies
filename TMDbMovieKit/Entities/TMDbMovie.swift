//
//  TMDbMovie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

private struct Keys {
    static let MovieID = "id"
    static let Title = "title"
    static let ReleaseDate = "release_date"
    static let Genre = "genre_ids"
    static let Overview = "overview"
    static let VoteAverage = "vote_average"
    static let Adult = "adult"
    static let Popularity = "popularity"
    static let PosterPath = "poster_path"
    static let BackdropPath = "backdrop_path"
}

public class TMDbMovie: NSObject, Mappable {
    
    public var movieID: Int = 0
    public var title: String = ""
    public var overview: String?
    public var releaseDate: NSDate?
    public var genres: [TMDbGenre] = []
    public var rating: Double?
    public var adult: Bool?
    public var posterPath: String?
    public var backDropPath: String?
    
    public required init?(_ map: Map) {
        guard map.JSONDictionary[Keys.MovieID] != nil else { return nil }
        guard map.JSONDictionary[Keys.Title] != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.movieID           <- map[Keys.MovieID]
        self.title             <- map[Keys.Title]
        self.overview          <- map[Keys.Overview]
        self.genres            <- map[Keys.Genre]
        self.rating            <- map[Keys.VoteAverage]
        self.adult             <- map[Keys.Adult]
        self.posterPath        <- map[Keys.PosterPath]
        self.backDropPath      <- map[Keys.BackdropPath]
        
        var dateString: String = ""
        dateString             <- map[Keys.ReleaseDate]
        self.releaseDate        = dateString.toDate()
    }
    
    // MARK: Equality
    
    override public func isEqual(object: AnyObject?) -> Bool {
        if let movie = object as? TMDbMovie {
            return movieID == movie.movieID
        }
        return false
    }
    
}
