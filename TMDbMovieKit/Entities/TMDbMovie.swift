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


public class TMDbMovie: NSObject, Mappable, NSCoding {
    
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
        guard map[Keys.MovieID].value() != nil else { return nil }
        guard map[Keys.Title].value() != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.movieID            <- map[Keys.MovieID]
        self.title              <- map[Keys.Title]
        self.overview           <- map[Keys.Overview]
        self.releaseDate        <- (map[Keys.ReleaseDate], DateTransform())
        self.genres             <- map[Keys.Genre]
        self.rating             <- map[Keys.VoteAverage]
        self.adult              <- map[Keys.Adult]
        self.posterPath         <- map[Keys.PosterPath]
        self.backDropPath       <- map[Keys.BackdropPath]
    }
    
    // MARK: - NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(movieID, forKey: Keys.MovieID)
        aCoder.encodeObject(title, forKey: Keys.Title)
        aCoder.encodeObject(overview, forKey: Keys.Overview)
        aCoder.encodeObject(releaseDate, forKey: Keys.ReleaseDate)
        aCoder.encodeObject(rating, forKey: Keys.VoteAverage)
        aCoder.encodeObject(adult, forKey: Keys.Adult)
        aCoder.encodeObject(posterPath, forKey: Keys.PosterPath)
        aCoder.encodeObject(backDropPath, forKey: Keys.BackdropPath)
        
        // Convert array of TMDbGenre to array of rawvalues
        let genreIDs = genres.map { return $0.rawValue }
        aCoder.encodeObject(genreIDs, forKey: Keys.Genre)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        guard let movieID = aDecoder.decodeObjectForKey(Keys.MovieID) as? Int else { return nil }
        guard let title = aDecoder.decodeObjectForKey(Keys.Title) as? String else { return nil }
        
        super.init()
        
        self.movieID = movieID
        self.title = title
        self.overview = aDecoder.decodeObjectForKey(Keys.Overview) as? String
        self.releaseDate = aDecoder.decodeObjectForKey(Keys.ReleaseDate) as? NSDate
        self.genres = aDecoder.decodeObjectForKey(Keys.Genre) as! [TMDbGenre]
        self.rating = aDecoder.decodeDoubleForKey(Keys.Adult)
        self.adult = aDecoder.decodeBoolForKey(Keys.PosterPath)
        self.posterPath = aDecoder.decodeObjectForKey(Keys.PosterPath) as? String
        self.backDropPath = aDecoder.decodeObjectForKey(Keys.BackdropPath) as? String
        
        // Retrieve genreIDs and convert them back to enum
        let genreIDs = aDecoder.decodeObjectForKey(Keys.Genre) as! [Int]
        self.genres = genreIDs.flatMap { return TMDbGenre(rawValue: $0) }
    }
    
}






