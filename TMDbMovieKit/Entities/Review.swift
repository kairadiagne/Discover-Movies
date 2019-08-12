//
//  Review.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Review: Codable {

    // MARK: Properties

    public let id: String
    public let author: String
    public let content: String
    public let url: URL

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author
        case content
        case url
    }
}
