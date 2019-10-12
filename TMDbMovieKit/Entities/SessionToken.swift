//
//  SessionToken.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 18/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

struct SessionToken: Equatable, Codable {

    // MARK: Properties

    let sessionID: String

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
    }
}
