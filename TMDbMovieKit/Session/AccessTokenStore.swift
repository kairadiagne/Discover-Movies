//
//  AccessTokenStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

/// Types conforming to `AccessTokenManaging` provide access to an access token.
protocol AccessTokenManaging: class {

    /// The access token needed to make authenticated calls with an API.
    var accessToken: String? { get }

    /// Stores the access token in the keychain.
    /// - Parameter accessToken: The access token to store in the keychain.
    func storeAccessToken(_ accessToken: String) throws

    /// Deletes the access token from the keychain.
    func deleteAccessToken() throws
}

final class AccessTokenStore: AccessTokenManaging {
    
    // MARK: - Types
    
    struct Constants {
        static let FreshInstallKey = "FreshInstallKey"
        static let server = "htps://www.themoviedb.org"
        static let account = "AccessToken"
    }

    // MARK: - Properties

    private(set) var accessToken: String?

    private let keychain: KeychainPassswordStoring

    private let keyValueStorage: KeyValueStorage

    // MARK: - Initialize

    init(keychain: KeychainWrapper = KeychainWrapper(), storage: KeyValueStorage = UserDefaults.standard) {
        self.keychain = keychain
        self.keyValueStorage = storage
        self.accessToken = try? keychain.readPassword(server: Constants.server, account: Constants.account)

        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = keyValueStorage.object(forKey: Constants.FreshInstallKey) as? Bool == false
        if freshInstall {
            keyValueStorage.set(true, forKey: Constants.FreshInstallKey)
            try? deleteAccessToken()
        }
    }
    
    // MARK: - SessionInfoContaining
    
    func storeAccessToken(_ accessToken: String) throws {
        try keychain.addOrUpdatePassword(accessToken, server: Constants.server, account: Constants.account)
        self.accessToken = accessToken
    }

    func deleteAccessToken() throws {
        try keychain.deletePasssword(server: Constants.server, account: Constants.account)
        accessToken = nil
    }
}
