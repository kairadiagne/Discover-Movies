//
//  AccessTokenStoreTests.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 29/03/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

import XCTest
@testable import TMDbMovieKit

final class AccessTokenStoreTests: BaseTestCase {
    
    /// It should remove the access token from the keychain when the store gets initialized on the first launch of the app.
    func testDeletesAccessTokenFromPreviousAppInstalOnFirstLaunch() {
        let keychainMock = KeychainMock()
        let keyValueStorageMock = KeyValueStorageMock()
        _ = AccessTokenStore(keychain: keychainMock, storage: keyValueStorageMock)
        
        XCTAssertEqual(keychainMock.deletePasswordCallCount, 1)
        XCTAssertEqual(keychainMock.server, AccessTokenStore.Constants.server)
        XCTAssertEqual(keychainMock.account, AccessTokenStore.Constants.account)
        XCTAssertEqual(keyValueStorageMock.bool(forKey: AccessTokenStore.Constants.FreshInstallKey), true)
    }
    
    /// It should retrieve the access token from the keychain and cache it when the store gets initialized.
    func testCachesAccessTokenWhenInitialized() {
        let accessToken = UUID().uuidString
        let keychainMock = KeychainMock(password: accessToken)
        let keyValueStorageMock = KeyValueStorageMock(initialValues: [AccessTokenStore.Constants.FreshInstallKey: true])
        let accessTokenStore = AccessTokenStore(keychain: keychainMock, storage: keyValueStorageMock)
        
        XCTAssertEqual(keychainMock.readPasswordCallCount, 1)
        XCTAssertEqual(keychainMock.server, AccessTokenStore.Constants.server)
        XCTAssertEqual(keychainMock.account, AccessTokenStore.Constants.account)
        XCTAssertEqual(accessTokenStore.cachedAccessToken, accessToken)
    }
    
    /// It should correctly store the access token.
    func testStoresAccessTokenInKeychain() {
        let keychainMock = KeychainMock()
        let keyValueStorageMock = KeyValueStorageMock(initialValues: [AccessTokenStore.Constants.FreshInstallKey: true])
        let accessTokenStore = AccessTokenStore(keychain: keychainMock, storage: keyValueStorageMock)
        
        let accessToken = UUID().uuidString
        XCTAssertNoThrow(try accessTokenStore.storeAccessToken(accessToken))
        
        XCTAssertEqual(accessTokenStore.cachedAccessToken, accessToken)
        XCTAssertEqual(keychainMock.addOrUpdatePasswordCallCount, 1)
        XCTAssertEqual(keychainMock.server, AccessTokenStore.Constants.server)
        XCTAssertEqual(keychainMock.account, AccessTokenStore.Constants.account)
        XCTAssertEqual(keychainMock.password, accessToken)
    }
    
    /// It should correctly delete the access token.
    func testDeletesAccessTokenInKeychain() {
        let keychainMock = KeychainMock(password: UUID().uuidString)
        let keyValueStorageMock = KeyValueStorageMock(initialValues: [AccessTokenStore.Constants.FreshInstallKey: true])
        let accessTokenStore = AccessTokenStore(keychain: keychainMock, storage: keyValueStorageMock)
        
        XCTAssertNoThrow(try accessTokenStore.deleteAccessToken())
        
        XCTAssertNil(accessTokenStore.cachedAccessToken)
        XCTAssertEqual(keychainMock.deletePasswordCallCount, 1)
        XCTAssertEqual(keychainMock.server, AccessTokenStore.Constants.server)
        XCTAssertEqual(keychainMock.account, AccessTokenStore.Constants.account)
    }
}

final class KeychainMock: KeychainPassswordStoring {
    
    private(set) var readPasswordCallCount = 0
    private(set) var addOrUpdatePasswordCallCount = 0
    private(set) var deletePasswordCallCount = 0
    
    private(set) var password: String?
    private(set) var server: String?
    private(set) var account: String?
    
    init(password: String? = nil) {
        self.password = password
    }
    
    func readPassword(server: String, account: String) throws -> String {
        readPasswordCallCount += 1
        self.server = server
        self.account = account
        return password ?? ""
    }
    
    func addOrUpdatePassword(_ password: String, server: String, account: String) throws {
        addOrUpdatePasswordCallCount += 1
        self.password = password
        self.server = server
        self.account = account
    }
    
    func deletePasssword(server: String, account: String) throws {
        deletePasswordCallCount += 1
        self.server = server
        self.account = account
    }
}
