//
//  CachedDataTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 12/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class CachedDataTests: XCTestCase {

    private var sut: CachedData<String>!

    override func tearDown() {
        sut = nil

        super.tearDown()
    }

    /// When the cache is empty needs refresh should return true.
    func testCachedataNeedsRefreshWhenEmpty() {
        sut = CachedData(refreshTimeOut: 500)

        XCTAssertTrue(sut.data == nil)
        XCTAssertTrue(sut.needsRefresh() == true)
    }

    /// When the cache has just been updated and the refresh timer did not expire needs refresh should return false.
    func testCachedDataNeedsRefreshIsFalseAfterUpdate() {
        let startDate = Date()
        let refreshInterval: TimeInterval = 500
        let dateGenerator = DateGeneratorMock(date: startDate)
        sut = CachedData(refreshTimeOut: refreshInterval, dateGenerator: dateGenerator)

        sut.data = "Initial data"
        XCTAssertTrue(sut.needsRefresh() == false)
        dateGenerator.travel(by: refreshInterval - 1)

        XCTAssertTrue(sut.needsRefresh() == false)
    }

    /// When the refresh timer for the cache data has expired needs refresh should return true.
    func testCachedDataNeedsRefreshAfterRefreshTimerExpired() {
        let startDate = Date()
        let refreshInterval: TimeInterval = 500
        let dateGenerator = DateGeneratorMock(date: startDate)
        sut = CachedData(refreshTimeOut: refreshInterval, dateGenerator: dateGenerator)

        sut.data = "Initial data"
        XCTAssertTrue(sut.needsRefresh() == false)
        dateGenerator.travel(by: refreshInterval + 1)

        XCTAssertTrue(sut.needsRefresh() == true)
    }

    /// It should need a refresh after the cache data has been reset. 
    func testCachedDataNeedsRefreshWhenSetToNil() {
        sut = CachedData(refreshTimeOut: 500)

        sut.data = "Initial data"
        XCTAssertTrue(sut.needsRefresh() == false)
        sut.data = nil

        XCTAssertTrue(sut.needsRefresh() == true)
    }
}
