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
    
    let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: Initializers
    
    public init() {
        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = NSUserDefaults.standardUserDefaults().stringForKey(Constants.FreshInstallKey) == nil
        
        if freshInstall {
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
    
}








