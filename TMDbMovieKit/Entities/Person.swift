//
//  PersonInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol PersonRepresentable: Codable {
    var id: Int { get }
    var name: String { get }
    var profilePath: String? { get }
}

public struct Person: PersonRepresentable, Equatable, Codable {

    // MARK: - Properties

    public let id: Int
    public let imdbId: String
    public let name: String
    public var gender: Int?
    public let adult: Bool?
    public let birthday: String?
    public let birthplace: String?
    public let deathday: String?
    public let biography: String?
    public let homepage: URL?
    public let profilePath: String?
    public let movieCredits: [MovieCredit] = []

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case id
        case imdbId = "imdb_id"
        case name
        case gender
        case adult
        case birthday
        case birthplace = "place_of_birth"
        case deathday
        case biography
        case homepage
        case profilePath = "profile_path"
        case movieCredits = "movie_credits"
    }
}
