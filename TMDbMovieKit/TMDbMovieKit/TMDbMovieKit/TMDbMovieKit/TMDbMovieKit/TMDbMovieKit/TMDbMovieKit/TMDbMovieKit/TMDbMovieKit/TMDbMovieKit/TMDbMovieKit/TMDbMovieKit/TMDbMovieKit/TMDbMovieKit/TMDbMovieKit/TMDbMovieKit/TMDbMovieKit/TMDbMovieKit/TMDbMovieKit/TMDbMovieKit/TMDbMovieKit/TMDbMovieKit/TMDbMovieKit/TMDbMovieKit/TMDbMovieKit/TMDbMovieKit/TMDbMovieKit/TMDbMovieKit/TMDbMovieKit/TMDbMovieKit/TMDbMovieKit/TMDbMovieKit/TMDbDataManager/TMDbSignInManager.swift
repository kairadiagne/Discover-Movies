//
//  TMDbSignInManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol TMDbSignInDelegate {
    func signInDelegateShouldRequestAuthorization(url: NSURL)
    func signInDelegateSigninDidFail(error: NSError)
    func signInDelegateSigninDidComplete()
}

public class TMDbSignInManager {
    
    public var delegate: TMDbSignInDelegate?
    private var isLoading = false
    private let signInClient = TMDbSignInClient()
    private let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Sign In
    
    public func requestToken() {
        isLoading = true
        
        signInClient.getRequestToken { (url, error) in
            
            guard error == nil else {
                self.isLoading = false
                self.delegate?.signInDelegateSigninDidFail(error!)
                return
            }
            
            if let url = url {
                self.delegate?.signInDelegateShouldRequestAuthorization(url)
            }
    
        }
    }
    
    public func requestSessionID() {
        
       signInClient.requestSessionID { (sessionID, error) in
        
            guard error == nil else {
                self.delegate?.signInDelegateSigninDidFail(error!)
                return
            }
        
            if let sessionID = sessionID {
                self.isLoading = false
                self.sessionInfoStore.persistSessionIDinStore(sessionID)
                self.delegate?.signInDelegateSigninDidComplete()
            }
        }
        
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
        let sessionInfoStore = TMDbSessionInfoStore()
        sessionInfoStore.deleteSessionIDFromStore()
        sessionInfoStore.deleteUserFromStore()
    }

}



