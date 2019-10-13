//
//  URLAppendQuetryItemTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 13/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class URLAppendQuetryItemTests: XCTestCase {

    /// It should add the given `URLQueryItem` to the query string of the URL when the url query is empty.
    func testAddsURLQueryItemWhenQueryIsEmpty() throws {
        let url = URL(string: "https://example.com")
        let newURL = try XCTUnwrap(url?.appending(queryItem: URLQueryItem(name: "test", value: "test")))
        XCTAssertTrue(newURL.absoluteString.contains("?test=test"))
    }

    /// It should add the given `URLQueryitem` to the query string of the url when the url query is not empty.
    func testAppendsURLQueryItemWhenQueryIsNotEmpty() throws {
        let url = URL(string: "https://example.com?test=test")
        let newURL = try XCTUnwrap(url?.appending(queryItem: URLQueryItem(name: "test2", value: "test2")))
        XCTAssertTrue(newURL.absoluteString.contains("?test=test&test2=test2"))
    }
}
