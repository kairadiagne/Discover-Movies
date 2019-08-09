//
//  TMDbSessionManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class TMDbSessionManager {
    
    // MARK: - Types

    public enum Status {
        case signedin
        case publicMode
        case unknown
    }
    
    private struct Constants {
        static let FreshInstallKey = "FreshInstallKey"
    }
    
    // MARK: - Properties
    
    public var user: User? {
        return sessionInfoStorage.user
    }
    
    private let sessionInfoStorage: SessionInfoContaining
    
    // MARK: - Initialize

    public convenience init() {
        self.init(storage: SessionInfoStorage(keyValueStorage: UserDefaults.standard))
    }
    
    init(storage: SessionInfoStorage) {
        self.sessionInfoStorage = storage
        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = UserDefaults.standard.bool(forKey: Constants.FreshInstallKey) == false
        
        if freshInstall {
            UserDefaults.standard.set(true, forKey: Constants.FreshInstallKey)
            sessionInfoStorage.clearUserData()
        }
    }

    // MARK: - API Key
    
    public static func registerAPIKey(_ key: String) {
        Configuration.configure(apiKey: key)
    }
    
    // MARK: - Signin Status
    
    public var status: Status {
        if sessionInfoStorage.sessionID != nil { return .signedin }
        if publicModeActivated { return .publicMode }
        return .unknown
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
    
    // MARK: - Sign Out
    
    public func signOut() {
        sessionInfoStorage.clearUserData()
    }
}
