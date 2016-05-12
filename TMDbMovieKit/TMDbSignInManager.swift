//
//  TMDbSignInManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol TMDbSignInDelegate {
    func TMDbSignInDelegateShouldRequestAuthorization(url: NSURL)
    func TMDbSignInDelegateSigninDidFail(error: NSError)
    func TMDbSignInDelegateSigninDidComplete()
}

public enum TMDBSigInStatus {
    case Signedin
    case PublicMode
    case NotAvailable
}

public class TMDbSignInManager {
    
    public var signInStatus: TMDBSigInStatus {
        if sessionInfoStore.sessionID != nil { return .Signedin }
        if publicModeActivated { return .PublicMode }
        return .NotAvailable
    }
    
    public var delegate: TMDbSignInDelegate?
    
    private let signInService = TMDbSignInService()
    
    private let sessionInfoStore = TMDbSessionInfoStore()

    // MARK: - Sign In
    
    public func requestToken() {
        signInService.getRequestToken { (url, error) in
            guard error == nil else {
                self.delegate?.TMDbSignInDelegateSigninDidFail(error!)
                return
            }
            
            if let url = url {
               self.delegate?.TMDbSignInDelegateShouldRequestAuthorization(url)
            }
        }
    }
    
    public func requestSessionID() {
        signInService.requestSessionID { (sessionID, error) in
            guard error != nil else {
                self.delegate?.TMDbSignInDelegateSigninDidFail(error!)
                return 
            }
            
            if let sessionID = sessionID {
                self.sessionInfoStore.persistSessionIDinStore(sessionID)
                self.delegate?.TMDbSignInDelegateSigninDidComplete()
            }
        }
    }
    
    // MARK: - Public Mode
    
    var publicModeActivated: Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey("userIsInpublicMode")
    }
    
    public func activatePublicMode() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "userIsInpublicMode")
    }
    
    public func deactivatePublicMode() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "userIsInpublicMode")
    }
    
    // MARK: - Sign Out
    
    public func signOut() {
        let sessionInfoStore = TMDbSessionInfoStore()
        sessionInfoStore.deleteSessionIDFromStore()
        sessionInfoStore.deleteUserFromStore()
    }

}



