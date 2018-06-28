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

    private var dateGenerator: DateGenerating = DateGenerator()

    private var lastUpdate: Date?

    var data: T? {
        didSet {
            if data == nil {
                lastUpdate = nil
            } else {
                lastUpdate = dateGenerator.getCurrentDate()
            }
        }
    }

    // MARK: - Initialize

    init(refreshTimeOut: TimeInterval, dateGenerator: DateGenerating = DateGenerator()) {
        self.refreshTimeOut = refreshTimeOut
        self.dateGenerator = dateGenerator
    }

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case refreshTimeOut
        case lastUpdate
    }

    // MARK: - Utils

    var needsRefresh: Bool {
        guard let lastUpdate = lastUpdate else { return true }
        let now = dateGenerator.getCurrentDate()
        return now.timeIntervalSince(lastUpdate) > refreshTimeOut
    }
}
