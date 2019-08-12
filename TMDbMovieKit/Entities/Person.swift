//
//  PersonInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol PersonRepresentable {
    var id: Int { get }
    var name: String { get }
    var profilePath: String? { get }
}

public struct Person: PersonRepresentable, Codable {

    // MARK: Properties

    public let id: Int
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
    public var cast: [MovieCredit]
    public var crew: [MovieCredit]

    public var movieCredits: [MovieCredit] {
        return cast + crew
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id = "id"
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
        id = try values.decode(Int.self, forKey: CodingKeys.id)
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
        cast = try movieCredits.decodeIfPresent([MovieCredit].self, forKey: .cast) ?? []
        crew = try movieCredits.decodeIfPresent([MovieCredit].self, forKey: .crew) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(imdbId, forKey: CodingKeys.imdbId)
        try container.encode(name, forKey: CodingKeys.name)
        try container.encode(gender, forKey: CodingKeys.gender)
        try container.encode(adult, forKey: CodingKeys.adult)
        try container.encodeIfPresent(birthDay, forKey: CodingKeys.birthDay)
        try container.encodeIfPresent(birthPlace, forKey: CodingKeys.birthPlace)
        try container.encodeIfPresent(deathDay, forKey: CodingKeys.deathDay)
        try container.encodeIfPresent(biography, forKey: CodingKeys.biography)
        try container.encodeIfPresent(homepage, forKey: CodingKeys.homepage)
        try container.encodeIfPresent(profilePath, forKey: CodingKeys.profilePath)
        var movieCredits = container.nestedContainer(keyedBy: MovieCreditsKeys.self, forKey: .movieCredits)
        try movieCredits.encode(cast, forKey: .cast)
        try movieCredits.encode(crew.self, forKey: .crew)
    }
}

