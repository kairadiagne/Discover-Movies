//
//  TMDBMovie.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol MovieRepresentable {
    var identifier: Int { get }
    var title: String { get }
    var releaseDate: String { get }
    var posterPath: String { get }
}

public struct TMDBMovie: MovieRepresentable, Decodable {

    // MARK: Properties

    public let identifier: Int
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let rating: Double
    public let posterPath: String
    public let backDropPath: String
    public let genres: [Int]

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title
        case overview
        case releaseDate = "release_date"
        case rating = "vote_average"
        case posterPath = "poster_path"
        case backDropPath = "backdrop_path"
        case genres = "genres"
        case genreIDs = "genre_ids"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try values.decode(Int.self, forKey: CodingKeys.identifier)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        overview = try values.decode(String.self, forKey: CodingKeys.overview)
        releaseDate = try values.decode(String.self, forKey: CodingKeys.releaseDate)
        rating = try values.decode(Double.self, forKey: CodingKeys.rating)
        posterPath = try values.decode(String.self, forKey: CodingKeys.posterPath)
        backDropPath = try values.decode(String.self, forKey: CodingKeys.backDropPath)
        if let genres = try? values.decode([Int].self, forKey: CodingKeys.genreIDs) {
            self.genres = genres
        } else if let genres = try? values.decode([Int].self, forKey: CodingKeys.genres) {
            self.genres = genres
        } else {
            genres = []
        }
    }
}
