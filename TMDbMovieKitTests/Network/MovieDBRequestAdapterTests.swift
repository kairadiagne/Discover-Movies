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
    
    private let readOnlyAccessToken = UUID().uuidString

    /// It should not adapt the request if it is not intended for the movie database API.
    func testDoesNotAdaptRequestWhenNotForMovieDatabaseAPI() throws {
        let accessTokenStoreMock = AccessTokenStoreMock()
        let sut = MovieDBRequestAdapter(accessTokenStore: accessTokenStoreMock, readOnlyAccessToken: readOnlyAccessToken)
        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        
        sut.adapt(urlRequest, for: session) { result in
            XCTAssertNotNil(result.value)
            XCTAssertNil(result.value?.value(forHTTPHeaderField: "Authorization"))
        }
    }

    /// It should add the read only access token to the Authorization header when the store does not contain an authenticated token.
    func testSetAuthorizationHeaderForRequestWithReadOnlyAccessToken() throws {
        let accessTokenStoreMock = AccessTokenStoreMock()
        let sut = MovieDBRequestAdapter(accessTokenStore: accessTokenStoreMock, readOnlyAccessToken: readOnlyAccessToken)
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/4?query=test")!)
        
        sut.adapt(urlRequest, for: session) { result in
            XCTAssertNotNil(result.value)
            XCTAssertNil(result.value?.value(forHTTPHeaderField: "Bearer \(self.readOnlyAccessToken)"))
        }
    }
    
    /// It should add the authenticated token to the Authorization header when the store contains one.
    func testSetAuthorizationheaderForRequesWithAuthenticatedToken() throws {
        let accessTokenStoreMock = AccessTokenStoreMock(accessToken: UUID().uuidString)
        let sut = MovieDBRequestAdapter(accessTokenStore: accessTokenStoreMock, readOnlyAccessToken: readOnlyAccessToken)
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/4?query=test")!)
        
        sut.adapt(urlRequest, for: session) { result in
            XCTAssertNotNil(result.value)
            XCTAssertEqual(result.value?.value(forHTTPHeaderField: "Authorization"), "Bearer \(accessTokenStoreMock.cachedAccessToken!)")
        }
    }
}
