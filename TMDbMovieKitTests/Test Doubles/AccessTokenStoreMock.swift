//
//  AccessTokenStoreMock.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 28/03/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

@testable import TMDbMovieKit

final class AccessTokenStoreMock: AccessTokenManaging {

    private(set) var storeAccessTokenCallCount = 0
    private(set) var deleteAccessTokenCallCount = 0
    private(set) var cachedAccessToken: String?
    
    init(accessToken: String? = nil) {
        self.cachedAccessToken = accessToken
    }

    func storeAccessToken(_ accessToken: String) {
        storeAccessTokenCallCount += 1
        cachedAccessToken = accessToken
    }

    func deleteAccessToken() {
        deleteAccessTokenCallCount += 1
        cachedAccessToken = nil
    }
}
