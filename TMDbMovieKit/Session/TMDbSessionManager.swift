//
//  TMDbSessionManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public enum TMDBSigInStatus {
    case signedin
    case publicMode
    case unkown
}

public class TMDbSessionManager {
    
    // MARK: - Types
    
    private struct Constants {
        static let FreshInstallKey = "FreshInstallKey"
    }
    
    // MARK: - Properties
    
    public var user: User? {
        return sessionInfoProvider.user
    }
    
    private let sessionInfoProvider: SessionInfoContaining
    
    // MARK: - Initialize
    
    init(sessionInfo: SessionInfoContaining = TMDbSessionInfoStore()) {
        self.sessionInfoProvider = sessionInfo
        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = UserDefaults.standard.bool(forKey: Constants.FreshInstallKey) == false
        
        if freshInstall {
            UserDefaults.standard.set(true, forKey: Constants.FreshInstallKey)
            sessionInfoProvider.clearUserData()
        }
    }
    
    public convenience init() {
        self.init(sessionInfo: TMDbSessionInfoStore())
    }
    
    // MARK: - API Key
    
    public func registerAPIKey(_ key: String) { // Candidate form removal 
        sessionInfoProvider.saveAPIKey(key)
    }
    
    // MARK: - Signin Status
    
    public var signInStatus: TMDBSigInStatus {
        if sessionInfoProvider.sessionID != nil { return .signedin }
        if publicModeActivated { return .publicMode }
        return .unkown
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
        sessionInfoProvider.clearUserData()
    }
    
}
