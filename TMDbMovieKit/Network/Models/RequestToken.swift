//
//  RequestToken.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct RequestToken: Decodable {

    // MARK: Properties

    let value: String

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case value = "request_token"
    }
}
