//
//  Movie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol MovieRepresentable {
    var id: Int { get }
    var title: String { get }
    var releaseDate: String { get }
    var posterPath: String { get }
}

public struct Movie: MovieRepresentable, Equatable, Codable {

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

    public var mainGenre: TMDbGenre? {
        return genres.first != nil ? TMDbGenre(rawValue: genres.first!) : nil
    }

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case genres // Add support for "genre_ids"
        case rating = "vote_average"
        case adult
        case posterPath = "poster_path"
        case backDropPath = "backdrop_path"
    }
}
