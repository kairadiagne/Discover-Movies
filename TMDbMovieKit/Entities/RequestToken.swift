//
//  RequestToken.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct RequestToken: Codable {

    // MARK: Properties

    let token: String

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case token = "request_token"
    }
}
