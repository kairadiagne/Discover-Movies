//
//  CastMember.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct CastMember: PersonRepresentable, Equatable, Codable {

    // MARK: - Properties

    public let id: Int
    public let castID: Int
    public let creditID: String
    public let name: String
    public let profilePath: String?
    public let character: String
    public let order: Int

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case id
        case castID = "cast_id"
        case creditID = "credit_id"
        case name
        case profilePath = "profile_path"
        case character
        case order
    }
}
