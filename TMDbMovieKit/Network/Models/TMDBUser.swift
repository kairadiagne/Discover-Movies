//
//  TMDBUser.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDBUser: Decodable {

    // MARK: Properties

    public let identifier: Int
    public let userName: String
    public let name: String?
    public let avatar: Gravatar?

    // MARK: Codable

    enum Codingkeys: String, CodingKey {
        case identifier = "id"
        case userName
        case name
        case avatar
    }
}
