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

    struct Entry: Hashable, Codable {
        let key: String
        let lastUpdate: Date
    }

    // MARK: Properties

    private let dateGenerator: DateGenerating

    private var cacheEntries = Set<Entry>()

    private let dataAccessQueue = DispatchQueue(label: "com.kairadiagne.tmdbmoviekit.cache.dataaccess", qos: .background, attributes: .concurrent)

    // MARK: Initialize

    init(dateGenerator: DateGenerating = DateGenerator()) {
        self.dateGenerator = dateGenerator
    }

    // MARK: CacheManaging

    func cache(cacheKey: String, lastUpdate: Date) {
        let entry = Entry(key: cacheKey, lastUpdate: lastUpdate)
        add(entry: entry)
    }

    func needsRefresh(cacheKey: String, refreshTimeout: TimeInterval) -> Bool {
        dataAccessQueue.sync {
            guard let lastUpdate = entry(for: cacheKey)?.lastUpdate else {
                return true
            }

            let now = dateGenerator.getCurrentDate()
            return now.timeIntervalSince(lastUpdate) > refreshTimeout
        }
    }

    // MARK: Helper

    private func add(entry: Entry) {
        dataAccessQueue.sync(flags: .barrier) {
            _ = cacheEntries.insert(entry)
        }
    }

    private func entry(for key: String) -> Entry? {
        dataAccessQueue.sync {
            return cacheEntries.first(where: { $0.key == key })
        }
    }
}
