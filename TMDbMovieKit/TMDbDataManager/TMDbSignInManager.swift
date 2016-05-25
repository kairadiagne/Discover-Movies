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
    
    public var inProgress = false
    
//    private let signInService = TMDbSignInService()
    
    private let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Sign In
    
    public func requestToken(redirectURI: String) {
//        inProgress = true
//        signInService.getRequestToken() { (url, error) in
//            guard error == nil else {
//                self.inProgress = false
//                self.delegate?.signInDelegateSigninDidFail(error!)
//                return
//            }
//            
//            print(url)
//            
//            if let url = url {
//               self.delegate?.signInDelegateShouldRequestAuthorization(url)
//            }
//        }
    }
    
    public func requestSessionID() {
//        signInService.requestSessionID { (sessionID, error) in
//            guard error == nil else {
//                self.inProgress = false
//                self.delegate?.signInDelegateSigninDidFail(error!)
//                return 
//            }
//            
//            if let sessionID = sessionID {
//                self.inProgress = false
//                self.sessionInfoStore.persistSessionIDinStore(sessionID)
//                self.delegate?.signInDelegateSigninDidComplete()
//            }
//        }
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



