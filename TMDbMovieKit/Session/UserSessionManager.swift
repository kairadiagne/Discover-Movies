//
//  UserSessionManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

///
public final class UserSessionManager {
    
    private struct Constants {
        static let FreshInstallKey = "FreshInstallKey"
    }

    enum State {

        ///
        case loggedOut

        ///
        case loggedIn

        ///
        case sessionExpired
    }
    
    private let sessionInfoStorage: SessionInfoContaining
    
    // MARK: - Initialize

    public convenience init() {
        self.init(storage: SessionInfoStorage(keyValueStorage: UserDefaults.standard))
    }
    
    init(storage: SessionInfoStorage) {
        self.sessionInfoStorage = storage

        // Move to keychain
        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = UserDefaults.standard.bool(forKey: Constants.FreshInstallKey) == false
        
        if freshInstall {
            UserDefaults.standard.set(true, forKey: Constants.FreshInstallKey)
            sessionInfoStorage.clearUserData()
        }
    }
}
