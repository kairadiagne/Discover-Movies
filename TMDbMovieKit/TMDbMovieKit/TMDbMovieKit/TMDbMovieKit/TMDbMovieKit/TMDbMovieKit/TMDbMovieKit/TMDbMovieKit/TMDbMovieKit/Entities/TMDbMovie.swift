//
//  TMDbMovie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class Movies: NSObject {
    
}

public struct Movie {
    
    public let id: Int
    public let title: String
    public let overView: String
    public let releaseDate: String
    public let genres: [Int]
    public let rating: Double
    public let adult: Bool
    public let posterPath: String
    public let backDropPath: String
    
}

extension Movie: DictionaryRepresentable {
    
    init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int,
            title = dict["title"] as? String,
            overView = dict["overview"] as? String,
            releaseDate = dict["release_date"] as? String,
            genres = dict["genre_ids"] as? [Int],
            rating = dict["vote_average"] as? Double,
            adult = dict["adult"] as? Bool,
            posterPath = dict["poster_path"] as? String,
            backDropPath = dict["backdrop_path"] as? String else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.overView = overView
        self.releaseDate = releaseDate
        self.genres = genres
        self.rating = rating
        self.adult = adult
        self.posterPath = posterPath
        self.backDropPath = backDropPath
    }
    
    func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["id"] = id
        dictionary["title"] = title
        dictionary["overview"] = overView
        dictionary["release_date"] = releaseDate
        dictionary["genre_ids"] = genres
        dictionary["vote_average"] = rating
        dictionary["adult"] = adult
        dictionary["poster_path"] = posterPath
        dictionary["backdrop_path"] = backDropPath
        return dictionary
    }

}





















//    static let MovieID = "id"
//    //        static let Title = "title"
//    //        static let ReleaseDate = "release_date"
//    //        static let Genre = "genre_ids"
//    //        static let Overview = "overview"
//    //        static let VoteAverage = "vote_average"
//    //        static let Adult = "adult"
//    //        static let PosterPath = "poster_path"
//    //        static let BackdropPath = "backdrop_path"

/*
 "adult": false,
 "backdrop_path": "/6bbZ6XyvgfjhQwbplnUh1LSj1ky.jpg",
 "genre_ids": [
 18
 ],
 "id": 244786,
 "original_language": "en",
 "original_title": "Whiplash",
 "overview": "Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.",
 "release_date": "2014-10-10",
 "poster_path": "/lIv1QinFqz4dlp5U4lQ6HaiskOZ.jpg",
 "popularity": 8.441533,
 "title": "Whiplash",
 "video": false,
 "vote_average": 8.5,
 "vote_count": 856
 */

import ObjectMapper

public struct TMDbMovie: Mappable, DictionaryRepresentable
{
    
    // MARK: Types
    
    struct Keys {
        static let MovieID = "id"
        static let Title = "title"
        static let ReleaseDate = "release_date"
        static let Genre = "genre_ids"
        static let Overview = "overview"
        static let VoteAverage = "vote_average"
        static let Adult = "adult"
        static let PosterPath = "poster_path"
        static let BackdropPath = "backdrop_path"
    }
    
    // MARK: Properties
    
    public var movieID: Int = 0
    public var title: String = ""
    public var overview: String?
    public var releaseDate: NSDate?
    public var genres: [TMDbGenre] = []
    public var rating: Double?
    public var adult: Bool?
    public var posterPath: String?
    public var backDropPath: String?
    
    // MARK: ObjectMapper
    
    public init?(_ map: Map) {
        guard map.JSONDictionary[Keys.MovieID] != nil else { return nil }
        guard map.JSONDictionary[Keys.Title] != nil else { return nil }
    }
    
    public mutating func mapping(map: Map) {
        self.movieID <- map[Keys.MovieID]
        self.title <- map[Keys.Title]
        self.overview <- map[Keys.Overview]
        self.genres <- map[Keys.Genre]
        self.rating <- map[Keys.VoteAverage]
        self.adult <- map[Keys.Adult]
        self.posterPath <- map[Keys.PosterPath]
        self.backDropPath <- map[Keys.BackdropPath]
        
        var dateString: String = ""
        dateString <- map[Keys.ReleaseDate]
        self.releaseDate = dateString.toDate()
    }
    
    // MARK: DictionaryRepresentable
    
    init?(dictionary: [String: AnyObject]) {
        guard let movieID = dictionary[Keys.MovieID] as? Int else { return nil }
        guard let title = dictionary[Keys.Title] as? String else { return nil }
        
        self.movieID = movieID
        self.title = title
        self.overview = dictionary[Keys.Overview] as? String
        self.genres = intsToGenres(dictionary[Keys.Genre] as? [Int])
        self.releaseDate = dictionary[Keys.ReleaseDate] as? NSDate
        self.rating = dictionary[Keys.VoteAverage] as? Double
        self.adult = dictionary[Keys.Adult] as? Bool
        self.posterPath = dictionary[Keys.PosterPath] as? String
        self.backDropPath = dictionary[Keys.BackdropPath] as? String
    }
    
    func dictionaryRepresentation() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary[Keys.MovieID] = movieID
        dictionary[Keys.Title] = title
        dictionary[Keys.Overview] = overview
        dictionary[Keys.Genre] = genresToInts(genres)
        dictionary[Keys.VoteAverage] = rating
        dictionary[Keys.Adult] = adult
        dictionary[Keys.PosterPath] = posterPath
        dictionary[Keys.BackdropPath] = backDropPath
        return dictionary
    }
    
    // MARK: Helper
    
    func genresToInts(genres: [TMDbGenre]) -> [Int] {
        var ints = [Int]()
        
        for genre in genres {
            ints.append(genre.rawValue)
        }
        
        return ints
    }
    
    func intsToGenres(ints: [Int]?) -> [TMDbGenre] {
        guard let ints = ints else { return [] }
        
        var genres = [TMDbGenre]()
        
        for int in ints {
            if let genre = TMDbGenre(rawValue: int) {
                genres.append(genre)
            }
        }
        
        return genres
    }
    
}


