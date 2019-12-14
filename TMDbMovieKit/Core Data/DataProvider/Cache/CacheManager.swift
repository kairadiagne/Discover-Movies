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

struct CacheEntry: Hashable, Codable {
    let cacheKey: String
    let lastUpdate: Date?
}

final class CacheManager: CacheManaging {

    // MARK: Properties

    private let dateGenerator: DateGenerating

    private var cacheEntries: Set<CacheEntry> = []

    // MARK: Initialize

    init(dateGenerator: DateGenerator = DateGenerator()) {
        self.dateGenerator = dateGenerator
    }

    // MARK: CacheManaging

    func cache(cacheKey: String, lastUpdate: Date) {
        let newEntry = CacheEntry(cacheKey: cacheKey, lastUpdate: lastUpdate)
        cacheEntries.insert(newEntry)
    }

    func needsRefresh(cacheKey: String, refreshTimeout: TimeInterval) -> Bool {
        guard let entry = cacheEntries.first(where: { $0.cacheKey == cacheKey }),
            let lastUpdate = entry.lastUpdate else {
                return true
        }

        let now = dateGenerator.getCurrentDate()
        return now.timeIntervalSince(lastUpdate) > refreshTimeout
    }
}
