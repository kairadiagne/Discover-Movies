//
//  Movie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Movie: DictionaryRepresentable, Equatable {
    
    // MARK: Properties
    
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let genres: [Int]
    public let rating: Double
    public let adult: Bool
    public let posterPath: String
    public let backDropPath: String
    
    // MARK: Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
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
        dictionary["id"] = id
        dictionary["title"] = title
        dictionary["overview"] = overview
        dictionary["release_date"] = releaseDate
        dictionary["genre_ids"] = genres
        dictionary["vote_average"] = rating
        dictionary["adult"] = adult
        dictionary["poster_path"] = posterPath
        dictionary["backdrop_path"] = backDropPath
        return dictionary
    }

}

public func ==(lhs: Movie, rhs: Movie) -> Bool {
    return  lhs.id == rhs.id ? true : false
}



