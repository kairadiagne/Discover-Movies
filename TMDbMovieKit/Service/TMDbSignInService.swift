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

/*
 TMDb authentication workflow: 
 
 - Step 1: Create a new request token: This is a temporary token that is required to ask the user for permission to access their account.
   You can generate any number of request tokens but hey will expire after 60 minutes. As soon as a valid sessionID has been created the token
   will be destroyed. 
 
 - Step 2: Ask the user for permission via the website: 
   The next step is to take the token you got from step 1 and direct your use to the following URL: 
   https://www.themoviedb.org/authenticate/REQUEST_TOKen
   The callback URK is also accessible via the Authentication-Callback header that gets returned.
   You can also pass in a redirect_param when making this call which will redirect the user once the authentication flow has been completed.
 
 - Step 3: Create a session ID: Assuming the reques token was authorized in step 2, you can nog go and request a session ID. 
   The results of this query will return a session_id value. This is the value required in all of the write methods.
 
*/

public class TMDbSignInService {
    
    public weak var delegate: TMDbSignInServiceDelegate?
    private var APIKey: String
    private let userInfoStore: TMDbUserInfoStore
    private var token: String = "" // TOD0: - Expirationdate ?
   
    public init(APIKey key: String) {
        self.APIKey = key
        self.userInfoStore = TMDbUserInfoStore()
    }
    
    // MARK: - Sign in 
    
    // Generates a valid request token for user based authentication
    
    public func requestToken() {
        
        Alamofire.request(TMDbSignInRouter.RequestToken(APIKey: APIKey)).validate().responseJSON { (response) in
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
    
    // Generates a session id for user based authentication
    
    public func requestSessionID(){
        Alamofire.request(TMDbSignInRouter.SessionID(token, APIKey: APIKey)).validate().responseJSON { (response) in
            guard response.result.error == nil else {
                self.delegate?.TMDbSignInServiceSignInDidFail(response.result.error!)
                return
            }
            
            if let sessionID = response.result.value?["session_id"] as? String {
                self.userInfoStore.persistSessionIDinStore(sessionID)
                // If we work with expirationdate of requestoken we set request token to nil
                self.delegate?.TMDbSignInServiceSignInDidComplete()
            }
        }
    }
    
    // Gets the basic information for an account
    
    public func fetchUserInfo() {
        guard let sessionID = userInfoStore.sessionID else { return }
        Alamofire.request(TMDbSignInRouter.UserInfo(sessionID, APIKey: APIKey)).validate().responseObject { (response: Response<TMDbUser, NSError>) in
            guard response.result.error == nil else {
                self.delegate?.TMDbSignInServiceSignInDidFail(response.result.error!)
                return
            }
            if let user = response.result.value {
                self.userInfoStore.persistUserInStore(user)
            }
        }
    }
    
    // MARK: - Continue without sign in 
    
    public func activatePublicMode() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "userIsInpublicMode")
    }
    
    // MARK: Helpers
    
    private func createAuthorizeURL(requestToken: String) -> NSURL? {
        let path: String = "\(TMDbAPI.AuthenticateURL)\(requestToken)"
        let url: NSURL = NSURL(string: path)! // TODO: Is in in this situation acceptable to forece unwrap
        return url
    }

}
