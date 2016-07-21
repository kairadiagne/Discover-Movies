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

// Use principles of launch mode manager

public class TMDbSessionManager {
    
    // MARK: Properties
    
    let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: Initializers
    
    public init() { }
    
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








