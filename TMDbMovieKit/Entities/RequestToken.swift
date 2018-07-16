//
//  RequestToken.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct RequestToken: Equatable, Codable {

    // MARK: - Properties

    let success: Bool
    let expiresAt: String
    let token: String

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case token = "request_token"
    }
}
