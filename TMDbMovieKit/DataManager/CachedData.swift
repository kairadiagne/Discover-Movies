//
//  CachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct CachedData<T: Codable>: Codable {
    
    // MARK: - Properties

    private let refreshTimeOut: TimeInterval

    private var lastUpdate: Date?

    var data: T? {
        didSet {
            if data == nil {
                lastUpdate = nil
            } else {
                lastUpdate = Date()
            }
        }
    }

    // MARK: - Init

    init(refreshTimeOut: TimeInterval) {
        self.refreshTimeOut = refreshTimeOut
    }

    // MARK: - Utils

    var needsRefresh: Bool {
        guard let lastUpdate = lastUpdate else { return true }
        return Date().timeIntervalSince(lastUpdate) > refreshTimeOut
    }
}
