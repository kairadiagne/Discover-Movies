//
//  BaseTestCase.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 12/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import XCTest
import Mocker
import Alamofire
@testable import TMDbMovieKit

class BaseTestCase: XCTestCase {

    private(set) var sessionManager: SessionManager!

    private(set) var apiKey: String!
    private(set) var readOnlyAPIKey: String!

    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self]
        sessionManager = SessionManager(configuration: configuration)

        apiKey = UUID().uuidString
        readOnlyAPIKey = UUID().uuidString

        DiscoverMoviesKit.configure(apiKey: apiKey, readOnlyApiKey: readOnlyAPIKey)
    }

    override func tearDown() {
        sessionManager = nil

        // Remove all mocks
    }
}
