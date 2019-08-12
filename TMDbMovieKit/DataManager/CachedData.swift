//
//  CachedData.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 21-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct CachedData<ModelType: Codable>: Codable {
    
    // MARK: - Properties
    
    var data: ModelType? {
        didSet {
            lastUpdate = data != nil ? dateGenerator.getCurrentDate() : nil
        }
    }

    let refreshTimeOut: TimeInterval

    private(set) var lastUpdate: Date?

    private var dateGenerator: DateGenerating = DateGenerator()

    // MARK: Initialize

    init(refreshTimeOut: TimeInterval, dateGenerator: DateGenerating = DateGenerator()) {
        self.refreshTimeOut = refreshTimeOut
        self.dateGenerator = dateGenerator
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case data
        case refreshTimeOut
        case lastUpdate
    }

    func needsRefresh() -> Bool {
        guard let lastUpdate = lastUpdate else { return true }
        let now = dateGenerator.getCurrentDate()
        return now.timeIntervalSince(lastUpdate) > refreshTimeOut
    }
}
