//
//  CachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

/// Manages the cache lifetime of objects in the database.
protocol CacheManaging {
    func cache(cacheKey: String, lastUpdate: Date)
    func needsRefresh(cacheKey: String, refreshTimeout: TimeInterval) -> Bool
}

final class CacheManager: CacheManaging {

    // MARK: Properties

    private let dateGenerator: DateGenerating

    private var cacheEntries: [String: Date] = [:]

    // MARK: Initialize

    init(dateGenerator: DateGenerating = DateGenerator()) {
        self.dateGenerator = dateGenerator
    }

    // MARK: CacheManaging

    func cache(cacheKey: String, lastUpdate: Date) {
        cacheEntries[cacheKey] = lastUpdate
    }

    func needsRefresh(cacheKey: String, refreshTimeout: TimeInterval) -> Bool {
        guard let lastUpdate = cacheEntries[cacheKey] else {
            return true
        }

        let now = dateGenerator.getCurrentDate()
        return now.timeIntervalSince(lastUpdate) > refreshTimeout
    }
}
