//
//  SessionToken.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 28-06-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation

struct SessionToken: Equatable, Codable {

    // MARK - Properties

    let sessionID: String

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
    }
}
