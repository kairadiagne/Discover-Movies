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
    static let GenreID = "genre_ids"
    static let GenreString = "genre_strings"
    static let Overview = "overview"
    static let VoteAverage = "vote_average"
    static let Adult = "adult"
    static let Popularity = "popularity"
    static let PosterPath = "poster_path"
    static let BackdropPath = "backdrop_path"
}


public class TMDbMovie: NSObject, Mappable, NSCoding {
    
    public var movieID: Int = 0
    public var title: String = ""
    public var overview: String?
    public var releaseDate: NSDate?
    public var genre: [TMDbGenre] = []
    public var rating: Double?
    public var adult: Bool?
    public var posterPath: String?
    public var backDropPath: String?
    
    
    public required init?(_ map: Map) {
        super.init()
        
        guard map[Keys.MovieID].value() != nil else { return nil }
        guard map[Keys.Title].value() != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.movieID            <- map[Keys.MovieID]
        self.title              <- map[Keys.Title]
        self.overview           <- map[Keys.Overview]
        self.releaseDate        <- (map[Keys.ReleaseDate], DateTransform())
        self.rating             <- map[Keys.VoteAverage]
        self.adult              <- map[Keys.Adult]
        self.posterPath         <- map[Keys.PosterPath]
        self.backDropPath       <- map[Keys.BackdropPath]
        
        // Genre
        for map[Keys.GenreID]
        
    }
    
    // MARK: - NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(movieID, forKey: Keys.MovieID)
        aCoder.encodeObject(title, forKey: Keys.Title)
        aCoder.encodeObject(overview, forKey: Keys.Overview)
        aCoder.encodeObject(releaseDate, forKey: Keys.ReleaseDate)
        aCoder
        aCoder.encodeObject(rating, forKey: Keys.VoteAverage)
        aCoder.encodeObject(adult, forKey: Keys.Adult)
        aCoder.encodeObject(posterPath, forKey: Keys.PosterPath)
        aCoder.encodeObject(backDropPath, forKey: Keys.BackdropPath)
    }
    
    self.genreStrings = genreIDs.map { return TMDbGenres.genreWithID($0)?.name }.flatMap { $0 }
    
    
    
    public required init?(coder aDecoder: NSCoder) {
        self.movieID = aDecoder.decodeObjectForKey(Keys.MovieID) as! Int
        self.title = aDecoder.decodeObjectForKey(Keys.Title) as! String
        self.overview = aDecoder.decodeObjectForKey(Keys.Overview) as? String
        self.releaseDate = aDecoder.decodeObjectForKey(Keys.ReleaseDate) as? NSDate
//        self.genre 
        self.rating = aDecoder.decodeObjectForKey(Keys.Adult) as? Double
        self.adult = aDecoder.decodeObjectForKey(Keys.Adult) as? Bool
        self.posterPath = aDecoder.decodeObjectForKey(Keys.PosterPath) as? String
        self.backDropPath = aDecoder.decodeObjectForKey(Keys.BackdropPath) as? String
    }
    
}





