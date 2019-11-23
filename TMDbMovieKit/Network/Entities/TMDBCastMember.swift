//
//  TMDBCastMember.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDBCastMember: PersonRepresentable, Codable {

    // MARK: Properties

    public let identifier: Int
    public let castID: Int
    public let creditID: String
    public let name: String
    public let character: String
    public let order: Int
    public let profilePath: String?

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case castID = "cast_id"
        case creditID = "credit_id"
        case name = "name"
        case character
        case order
        case profilePath = "profile_path"
    }
}
