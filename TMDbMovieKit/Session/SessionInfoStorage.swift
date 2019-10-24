//
//  SessionInfoStorage.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol SessionInfoContaining: class {

    ///
    var accessToken: String? { get }

    ///
    func storeAccessToken(_ accessToken: String)

    ///
    func deleteAccessToken()
}

final class SessionInfoStorage: SessionInfoContaining {
    
    // MARK: - Types
    
    struct Keys {
        static let server = "htps://www.themoviedb.org"
        static let account = "AccessToken"
    }

    // MARK: - Properties

    private(set) var accessToken: String?

    private let keychain: KeychainPassswordStoring

    // MARK: - Initialize

    init(keychain: KeychainWrapper = KeychainWrapper()) {
        self.keychain = keychain
        self.accessToken = try? keychain.readItem(server: Keys.server, account: Keys.account)
    }
    
    // MARK: - SessionInfoContaining
    
    func storeAccessToken(_ accessToken: String) {
        try? keychain.addOrUpdateItem(accessToken, server: Keys.server, account: Keys.account)
    }

    func deleteAccessToken() {
        try? keychain.deleteItem(server: Keys.server, account: Keys.account)
    }
}
