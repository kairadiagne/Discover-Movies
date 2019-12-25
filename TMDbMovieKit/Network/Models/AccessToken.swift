//
//  AccessToken.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 16/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

struct AccessToken: Decodable {

    // MARK: Properties

    let value: String
    let accountIdentifier: String

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case value = "access_token"
        case accountIdentifier = "account_id"
    }
}
