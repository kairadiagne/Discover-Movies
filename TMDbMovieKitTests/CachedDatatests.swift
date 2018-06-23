//
//  CachedDatatests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 11-06-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

class CachedDatatests: XCTestCase {

    var sut: CachedData<String>!

    func testNeedsRefreshBecauseIsEmpty() {
        // Given
        sut = CachedData(refreshTimeOut: 500, dateGenerator: MockDateGenerator())

        // Then
        XCTAssertTrue(sut.needsRefresh)
    }

    func testNeedsRefreshAfterUpdate() {
        // Given
        let mockDateGenerator = MockDateGenerator()
        sut = CachedData(refreshTimeOut: 500, dateGenerator: mockDateGenerator)

        // Then
        sut.data = "TestData"
        XCTAssertFalse(sut.needsRefresh)
        mockDateGenerator.travel(by: 1000)

        // Then
        XCTAssertTrue(sut.needsRefresh)
    }
}
