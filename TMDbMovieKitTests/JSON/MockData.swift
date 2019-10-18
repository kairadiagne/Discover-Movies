//
//  MockData.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 12/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

/// Contains all available data mocks
final class MockedData {
    static let requestTokenResponse = Bundle(for: MockedData.self).url(forResource: "RequestToken", withExtension: "json")!.data
    static let accessTokenResponse = Bundle(for: MockedData.self).url(forResource: "AccessToken", withExtension: "json")!.data
}

extension URL {

    /// Returns a `Data` representation of the current `URL`. Force unwrapping as it's only used for tests.
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
