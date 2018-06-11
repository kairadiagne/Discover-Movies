//
//  User.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct User: Equatable, Codable {

    // MARK: - Properties

    public let id: Int
    public let username: String
    public let name: String?
    public let avatar: Avatar?
}
