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

    public var userIsLoggedIn: Bool {
        return sessionInfoStorage.accessToken != nil
    }
    
    private let sessionInfoStorage: SessionInfoContaining

    // MARK: - Initialize

    public convenience init() {
        self.init(storage: SessionInfoStorage())
    }
    
    init(storage: SessionInfoStorage) {
        self.sessionInfoStorage = storage

        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = UserDefaults.standard.bool(forKey: Constants.FreshInstallKey) == false
        
        if freshInstall {
            UserDefaults.standard.set(true, forKey: Constants.FreshInstallKey)
            sessionInfoStorage.deleteAccessToken()
        }
    }
}
