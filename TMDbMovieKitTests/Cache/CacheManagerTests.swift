//
//  CacheManagerTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 12/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class CacheManagerTests: XCTestCase {

    private var cacheKey = "cachekey"
    private var refreshTimeOut: TimeInterval = 500

    /// When the cache does not contain an entry needs refresh should return true.
    func testNeedsRefreshWhenDoesNotContainCacheEntry() {
        let sut = CacheManager()
        XCTAssertTrue(sut.needsRefresh(cacheKey: cacheKey, refreshTimeout: refreshTimeOut))
    }

    /// When the cache contains an entry and the refresh timeout has not expired needs refresh should return false.
    func testNeedsRefreshIsFalseAfterUpdate() {
        let startDate = Date()
        let dateGenerator = DateGeneratorMock(date: startDate)
        let sut = CacheManager(dateGenerator: dateGenerator)
        sut.cache(cacheKey: cacheKey, lastUpdate: startDate)
        
        XCTAssertFalse(sut.needsRefresh(cacheKey: cacheKey, refreshTimeout: refreshTimeOut))

        dateGenerator.travel(by: refreshTimeOut - 1)

        XCTAssertFalse(sut.needsRefresh(cacheKey: cacheKey, refreshTimeout: refreshTimeOut))
    }

    /// When the refresh timer for the cache entry has expired needs refresh should return true.
    func testNeedsRefreshAfterRefreshTimerExpired() {
        let startDate = Date()
        let dateGenerator = DateGeneratorMock(date: startDate)
        let sut = CacheManager(dateGenerator: dateGenerator)
        sut.cache(cacheKey: cacheKey, lastUpdate: startDate)

        XCTAssertFalse(sut.needsRefresh(cacheKey: cacheKey, refreshTimeout: refreshTimeOut))

        dateGenerator.travel(by: refreshTimeOut + 1)

        XCTAssertTrue(sut.needsRefresh(cacheKey: cacheKey, refreshTimeout: refreshTimeOut))
    }
}
