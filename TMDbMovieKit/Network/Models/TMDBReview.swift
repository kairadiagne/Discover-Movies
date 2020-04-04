//
//  TMDBReview.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDBReview: Decodable {

    // MARK: Properties

    public let identifier: String
    public let author: String
    public let content: String
    public let url: URL

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case author
        case content
        case url
    }
}
