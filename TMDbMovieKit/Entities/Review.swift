//
//  Review.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Review: Equatable, Codable {

    // MARK: - Properties

    public let id: String
    public let author: String
    public let content: String
    public let url: URL
}
