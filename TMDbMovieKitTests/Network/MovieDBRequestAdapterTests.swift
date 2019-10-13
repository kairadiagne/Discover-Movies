//
//  MovieDBRequestAdapterTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 13/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class MovieDBRequestAdapterTests: BaseTestCase {

    /// It should not adapt the request if it is not intended for the movie database API.
    func testDoesNotAdaptRequestWhenNotForMovieDatabaseAPI() throws {
        let sut = MovieDBRequestAdapter()
        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        XCTAssertEqual(try sut.adapt(urlRequest), urlRequest)
    }

    /// It should add the API key as a query paramater to the request when dealing with a 3 API request which URL already contains a query paramater.
    func testAddsAPIKeyAsURLQueryParamaterForV3Request() throws {
        let sut = MovieDBRequestAdapter()
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3")!)

        let adaptedRequest = try sut.adapt(urlRequest)
        XCTAssertEqual(adaptedRequest.url?.absoluteString.contains("api_key=\(apiKey!)"), true)
    }

    /// It should add the API key as a query paramater to the request when dealing with a v3 API request which URL already contains a query parameter.
    func testAppendsAPIKeyAsURLQueryParamaterForV3Request() throws {
        let sut = MovieDBRequestAdapter()
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3?query=test")!)

        let adaptedRequest = try sut.adapt(urlRequest)
        XCTAssertEqual(adaptedRequest.url?.absoluteString.contains("api_key=\(apiKey!)"), true)
        XCTAssertEqual(adaptedRequest.url?.absoluteString.contains("query=test"), true)
    }

    /// It should add the bearer token to the Authorization header when dealing with a request intended for the v4 API.
    func testSetAuthorizationHeaderForV4Request() throws {
        let sut = MovieDBRequestAdapter()
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/4?query=test")!)

        let adaptedRequest = try sut.adapt(urlRequest)
        XCTAssertEqual(adaptedRequest.value(forHTTPHeaderField: "Authorization"), "Bearer \(readOnlyAPIKey!)")
    }

    /// It should not add the API key as a query paramater to the request when dealing with a request intended for the v4 API.
    func testDoesNotAddAPIKeyAsQueryParamaterForV3Request() throws {
        let sut = MovieDBRequestAdapter()
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/4")!)

        let adaptedRequest = try sut.adapt(urlRequest)
        XCTAssertEqual(adaptedRequest.url?.absoluteString.contains("api_key=\(apiKey!)"), false)
    }

    /// It should not add the bearer token to the Authorization header when dealing with a request intended for the v3 API.
    func testDoesNotAddAuthorizationHeaderForV3Request() throws {
        let sut = MovieDBRequestAdapter()
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3")!)

        let adaptedRequest = try sut.adapt(urlRequest)
        XCTAssertNil(adaptedRequest.value(forHTTPHeaderField: "Authorization"))
    }
}
