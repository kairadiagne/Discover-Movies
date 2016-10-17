//
//  Movie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Movie: DictionarySerializable, Equatable {
    
    // MARK: - Properties
    
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let genres: [Int]
    public let rating: Double
    public let adult: Bool
    public let posterPath: String
    public let backDropPath: String
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int,
            let title = dict["title"] as? String,
            let overView = dict["overview"] as? String,
            let releaseDate = dict["release_date"] as? String,
            let genres = dict["genre_ids"] as? [Int],
            let rating = dict["vote_average"] as? Double,
            let adult = dict["adult"] as? Bool,
            let posterPath = dict["poster_path"] as? String,
            let backDropPath = dict["backdrop_path"] as? String else {
                return nil
        }
        
        self.id = id
        self.title = title
        self.overview = overView
        self.releaseDate = releaseDate
        self.genres = genres
        self.rating = rating
        self.adult = adult
        self.posterPath = posterPath
        self.backDropPath = backDropPath
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["id"] = id as AnyObject?
        dictionary["title"] = title as AnyObject?
        dictionary["overview"] = overview as AnyObject?
        dictionary["release_date"] = releaseDate as AnyObject?
        dictionary["genre_ids"] = genres as AnyObject?
        dictionary["vote_average"] = rating as AnyObject?
        dictionary["adult"] = adult as AnyObject?
        dictionary["poster_path"] = posterPath as AnyObject?
        dictionary["backdrop_path"] = backDropPath as AnyObject?
        return dictionary
    }
    
    // MARK: - Utils
    
    public func mainGenre() -> TMDbGenre? {
        if let rawValue = genres.first {
            return TMDbGenre(rawValue: rawValue)
        }
        
        return nil
    }

}

public func ==(lhs: Movie, rhs: Movie) -> Bool {
    return  lhs.id == rhs.id ? true : false
}



