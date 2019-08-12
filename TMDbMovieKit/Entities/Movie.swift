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

public struct Movie: MovieRepresentable, Codable {

    // MARK: Properties

    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let rating: Double
    public let adult: Bool
    public let posterPath: String
    public let backDropPath: String

    private let genres: [Int]
    private let genereIDs: [Int]
    
    public var mainGenre: TMDbGenre? {
        guard let rawValue = genres.first ?? genereIDs.first else { return nil }
        return TMDbGenre(rawValue: rawValue)
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title
        case overview
        case releaseDate = "release_date"
        case rating = "vote_average"
        case adult
        case posterPath = "poster_path"
        case backDropPath = "backdrop_path"
        case genres = "genres"
        case genreIDs = "genere_ids"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: CodingKeys.id)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        overview = try values.decode(String.self, forKey: CodingKeys.overview)
        releaseDate = try values.decode(String.self, forKey: CodingKeys.overview)
        rating = try values.decode(Double.self, forKey: CodingKeys.rating)
        adult = try values.decode(Bool.self, forKey: CodingKeys.adult)
        posterPath = try values.decode(String.self, forKey: CodingKeys.posterPath)
        backDropPath = try values.decode(String.self, forKey: CodingKeys.backDropPath)
        genres = try values.decodeIfPresent([Int].self, forKey: CodingKeys.genres) ?? []
        genereIDs = try values.decodeIfPresent([Int].self, forKey: CodingKeys.genreIDs) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(title, forKey: CodingKeys.title)
        try container.encode(overview, forKey: CodingKeys.overview)
        try container.encode(releaseDate, forKey: CodingKeys.releaseDate)
        try container.encode(rating, forKey: CodingKeys.rating)
        try container.encode(adult, forKey: CodingKeys.adult)
        try container.encode(posterPath, forKey: CodingKeys.posterPath)
        try container.encode(backDropPath, forKey: CodingKeys.backDropPath)
        try container.encode(genres, forKey: CodingKeys.genres)
        try container.encode(genereIDs, forKey: CodingKeys.genreIDs)
    }
}
