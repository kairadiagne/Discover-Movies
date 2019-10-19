//
//  UserSessionManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

// This becomes more Discover logic
public final class UserSessionManager {

    public enum Status {

        // On first install we should request the status

        /// The user us signed in with a TMDB account
        case signedin

        /// The user choose not to sign in or is signed out.
        case publicMode
    }
    
    private struct Constants {
        static let FreshInstallKey = "FreshInstallKey"
    }

    public var status: Status {
        return .publicMode
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

    // MARK: - Signin Status

    func logOut() {
    }
    
    // MARK: - Public Mode
    
    private var publicModeActivated: Bool {
        return UserDefaults.standard.bool(forKey: "userIsInpublicMode")
    }

    public func activatePublicMode() {
        UserDefaults.standard.set(true, forKey: "userIsInpublicMode")
    }
    
    public func deactivatePublicMode() {
        UserDefaults.standard.set(false, forKey: "userIsInpublicMode")
    }
}
