//
//  TMDbGenres.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 28-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDbGenre {
    var id: Int
    var name: String
}

public struct TMDbGenres {
    
    // MARK: - Properties
    
    private static let genres = [ TMDbGenre(id: 28, name: "Action"),
                   TMDbGenre(id: 12, name: "Adventure"),
                   TMDbGenre(id: 16, name: "Animation"),
                   TMDbGenre(id: 35, name: "Comedy"),
                   TMDbGenre(id: 80, name: "Crime"),
                   TMDbGenre(id: 99, name: "Documentary"),
                   TMDbGenre(id: 18, name: "Drama"),
                   TMDbGenre(id: 10751, name: "Family"),
                   TMDbGenre(id: 14, name: "Fantasy"),
                   TMDbGenre(id: 10769, name: "Foreign"),
                   TMDbGenre(id: 36, name: "History"),
                   TMDbGenre(id: 27, name: "Horror"),
                   TMDbGenre(id: 10402, name: "Music"),
                   TMDbGenre(id: 9648, name: "Mystery"),
                   TMDbGenre(id: 10749, name: "Romance"),
                   TMDbGenre(id: 878, name: "Science Fiction"),
                   TMDbGenre(id: 10770, name: "TV Movie"),
                   TMDbGenre(id: 53, name: "Thriller"),
                   TMDbGenre(id: 10752, name: "War"),
                   TMDbGenre(id: 37, name: "Western")
    ]
    
    // MARK: - Retrieval
    
    public static func genreWithID(genreID: Int) -> TMDbGenre? {
        return self.genres.filter { $0.id == genreID }.first
    }
    
    public static func idForGenreWithName(name: String) -> Int? {
        return self.genres.filter { $0.name == name }.first?.id
    }
    
    public static func allGenresAsString() -> [String] {
        return genres.map { return $0.name }
    }
    
    public static func mainGenre() -> String {
        return genres.first?.name ?? ""
    }
    
}
