//
//  Result+ExtensionsTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 29/03/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class ResultExtensionsTests: BaseTestCase {
    
    /// It should return the error in case of failure.
    func testReturnsErrorInCaseOfFailure() {
        let result: Result<String, Error> = .failure(URLError(.notConnectedToInternet))
        XCTAssertNotNil(result.error)
    }
    
    /// It should return nil for the error in case of success.
    func testReturnsNilErrorInCaseOfSuccess() {
        let result: Result<String, Error> = .success("test")
        XCTAssertNil(result.error)
    }
    
    /// It should return the value  in case of a success.
    func testReturnsValueInCaseOfSuccess() {
        let result: Result<String, Error> = .success("test")
        XCTAssertEqual(result.value, "test")
    }
    
    /// It should return nil for the value in case of a failure.
    func testReturnsNilValueInCaseOfFailure() {
        let result: Result<String, Error> = .failure(URLError(.notConnectedToInternet))
        XCTAssertNil(result.value)
    }
}
