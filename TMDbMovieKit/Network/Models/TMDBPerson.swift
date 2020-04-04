//
//  TMDBPerson.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol PersonRepresentable {
    var identifier: Int { get }
    var name: String { get }
    var profilePath: String? { get }
}

public struct TMDBPerson: PersonRepresentable, Decodable {

    // MARK: Properties

    public let identifier: Int
    public let imdbId: String
    public let name: String
    public var gender: Int
    public let adult: Bool
    public var birthDay: String?
    public var birthPlace: String?
    public var deathDay: String?
    public var biography: String?
    public var homepage: URL?
    public var profilePath: String?
    public var cast: [TMDBMovieCredit]
    public var crew: [TMDBMovieCredit]

    public var movieCredits: [TMDBMovieCredit] {
        return cast + crew
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case imdbId = "imdb_id"
        case name
        case gender
        case adult
        case birthDay = "birthday"
        case birthPlace = "place_of_birth"
        case deathDay = "deathday"
        case biography
        case homepage
        case profilePath = "profile_path"
        case movieCredits = "movie_credits"
    }

    enum MovieCreditsKeys: String, CodingKey {
        case cast
        case crew
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try values.decode(Int.self, forKey: CodingKeys.identifier)
        imdbId = try values.decode(String.self, forKey: CodingKeys.imdbId)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        gender = try values.decode(Int.self, forKey: CodingKeys.gender)
        adult = try values.decode(Bool.self, forKey: CodingKeys.adult)
        birthDay = try values.decode(String.self, forKey: CodingKeys.birthDay)
        birthPlace = try values.decodeIfPresent(String.self, forKey: CodingKeys.birthPlace)
        deathDay = try values.decodeIfPresent(String.self, forKey: CodingKeys.deathDay)
        biography = try values.decodeIfPresent(String.self, forKey: CodingKeys.biography)
        homepage = try values.decodeIfPresent(URL.self, forKey: CodingKeys.homepage)
        profilePath = try values.decode(String.self, forKey: CodingKeys.profilePath)
        let movieCredits = try values.nestedContainer(keyedBy: MovieCreditsKeys.self, forKey: .movieCredits)
        cast = try movieCredits.decodeIfPresent([TMDBMovieCredit].self, forKey: .cast) ?? []
        crew = try movieCredits.decodeIfPresent([TMDBMovieCredit].self, forKey: .crew) ?? []
    }
}
