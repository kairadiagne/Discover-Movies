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
    
    // MARK: Types 
    
    private struct Constants {
        static let FreshInstallKey = "FreshInstallKey"
    }
    
    // MARK: Properties
    
    public static let shared = TMDbSessionManager()
    
    public var user: User? {
        return sessionInfoStore.user
    }
    
    private let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: Initialize
    
    public init() {
        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = NSUserDefaults.standardUserDefaults().boolForKey(Constants.FreshInstallKey) == false
        
        if freshInstall {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: Constants.FreshInstallKey)
            sessionInfoStore.deleteSessionIDFromStore()
        }
        
    }
    
    // MARK: - API Key
    
    public func registerAPIKey(APIKey key: String) {
        sessionInfoStore.APIKey = key
    }
    
    // MARK: - Signin Status
    
    public var signInStatus: TMDBSigInStatus {
        if sessionInfoStore.sessionID != nil { return .Signedin }
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
        sessionInfoStore.deleteSessionIDFromStore()
        sessionInfoStore.deleteUserFromStore()
    }
    
}










