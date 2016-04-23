//
//  TMDbSignInService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class TMDbSignInService {
    
    public weak var delegate: TMDbSignInServiceDelegate?
    private var userStore: TMDbUserStore
    private var token: String = "" // TOD0: - Expirationdate ?
   
    public init() {
        self.userStore = TMDbUserStore()
    }
    
    // MARK: - Sign in calls
    
    public func requestToken() {
        Alamofire.request(TMDbSignInRouter.RequestToken).validate().responseJSON { (response) in
            guard response.result.error == nil else {
                self.delegate?.TMDbSignInServiceCouldNotObtainToken(response.result.error!)
                return
            }
            
            if let token = response.result.value?["request_token"] as? String {
                self.token = token
                let authorizeURL = self.createAuthorizeURL(token)
                self.delegate?.TMDbSignInServiceDidObtainToken(authorizeURL)
            }
        }
    }
    
    public func requestSessionID(){
        Alamofire.request(TMDbSignInRouter.SessionID(token)).validate().responseJSON { (response) in
            guard response.result.error == nil else {
                self.delegate?.TMDbSignInServiceSignInDidFail(response.result.error!)
                return
            }
            
            if let sessionID = response.result.value?["session_id"] as? String {
                self.userStore.persistSessionIDinStore(sessionID)
                self.userStore.fetchUserInfo()
                self.userStore.userIsInPublicMode = false
                // If we work with expirationdate of requestoken we set request token to nil 
                self.delegate?.TMDbSignInServiceSignInDidComplete()
            }
        }
    }
    
    // MARK: - Continue without sign in 
    
    public func activatePublicMode() {
        userStore.userIsInPublicMode = true
    }
    
    // MARK: Helpers
    
    private func createAuthorizeURL(requestToken: String) -> NSURL? {
        let path: String = "\(TMDbAPI.AuthenticateURL)\(requestToken)"
        let url: NSURL = NSURL(string: path)! // TODO: Is in in this situation acceptable to forece unwrap
        return url
    }

}
