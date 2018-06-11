//
//  MovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieCredit: MovieRepresentable, Equatable, Codable {

    // MARK: - Properties

    public let id: Int
    public let creditId: String
    public let title: String
    public let releaseDate: String
    public let posterPath: String

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case id
        case creditId = "credit_id"
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}
