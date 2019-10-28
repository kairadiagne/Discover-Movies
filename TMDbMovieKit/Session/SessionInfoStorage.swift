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
            deleteAccessToken()
        }
    }
    
    // MARK: - SessionInfoContaining
    
    func storeAccessToken(_ accessToken: String) {
        try? keychain.addOrUpdatePassword(accessToken, server: Constants.server, account: Constants.account)
        
    }

    func deleteAccessToken() {
        try? keychain.deletePasssword(server: Constants.server, account: Constants.account)
    }
}
