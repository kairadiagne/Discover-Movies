//
//  TMDbSessionManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Locksmith

public enum TMDBSigInStatus {
    case Signedin
    case PublicMode
    case NotAvailable
}

public class TMDbSessionManager {
    
    // MARK: - Types
    
    private struct Constants {
        static let FreshInstallKey = "FreshInstallKey"
    }
    
    // MARK: - Properties
    
    public static let shared = TMDbSessionManager()
    
    public var user: User? {
        return sessionInfoProvider.user
    }
    
    private let sessionInfoProvider: SessionInfoContaining
    
    // MARK: - Initialize
    
    init(sessionInfo: SessionInfoContaining = TMDbSessionInfoStore()) {
        self.sessionInfoProvider = sessionInfo
        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = NSUserDefaults.standardUserDefaults().boolForKey(Constants.FreshInstallKey) == false
        
        if freshInstall {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: Constants.FreshInstallKey)
            sessionInfoProvider.clearUserData()
        }
    }
    
    // MARK: - API Key
    
    public func registerAPIKey(key: String) {
        sessionInfoProvider.saveAPIKey(key)
    }
    
    // MARK: - Signin Status
    
    public var signInStatus: TMDBSigInStatus {
        if sessionInfoProvider.sessionID != nil { return .Signedin }
        if publicModeActivated { return .PublicMode }
        return .NotAvailable
    }
    
    private var publicModeActivated: Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey("userIsInpublicMode")
    }
    
    // MARK: - Public Mode
    
    public func activatePublicMode() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "userIsInpublicMode")
    }
    
    public func deactivatePublicMode() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "userIsInpublicMode")
    }
    
    // MARK: - Sign Out
    
    public func signOut() {
        sessionInfoProvider.clearUserData()
    }
    
}










