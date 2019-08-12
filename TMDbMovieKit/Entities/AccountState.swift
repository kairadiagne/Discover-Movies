//
//  AccountState.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct AccountState: Codable {

    // MARK: Properties

    public let favoriteStatus: Bool
    public let watchlistStatus: Bool

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case favoriteStatus = "favorite"
        case watchlistStatus = "watchlist"
    }
}
