//
//  CrewMember.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct CrewMember: PersonRepresentable, Equatable {

    // MARK: - Properties

    public let id: Int
    public let creditID: String
    public let name: String
    public let department: String
    public let job: String
    public let profilePath: String?

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name
        case department
        case job
        case profilePath = "profile_path"
    }
}
