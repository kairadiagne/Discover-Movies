//
//  TMDbSignInService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

// TODO: - Almofire requets with completiohandler that returns on the main thread

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

class TMDbSignInService {
    
    private var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    private var requestToken = ""
    
    // MARK: - Sign in 
    
    // Generates a valid request token for user based authentication
    
    func getRequestToken(redirectURI: String, completionHandler: (url: NSURL?, error: NSError?) -> ()) {
        Alamofire.request(TMDbSignInRouter.RequestToken(APIKey: APIKey)).validate().responseJSON { (response) in
            guard response.result.error == nil else {
                completionHandler(url: nil, error: response.result.error!)
                return
            }
            
            if let token = response.result.value?["request_token"] as? String {
                self.requestToken = token
                let url = self.createAuthorizeURL(self.requestToken, redirectURI: redirectURI)
                completionHandler(url: url, error: nil)
            }
        }
    }
    
    // Generates a session id for user based authentication
    
    func requestSessionID(completionHandler: (sessionID: String?, error: NSError?) -> ()) {
        Alamofire.request(TMDbSignInRouter.SessionID(requestToken, APIKey: APIKey)).validate().responseJSON { (response) in
            guard response.result.error == nil else {
                completionHandler(sessionID: nil, error: response.result.error!)
                return
            }
            
            if let sessionID = response.result.value?["session_id"] as? String {
                completionHandler(sessionID: sessionID, error: response.result.error!)
            }
        }
    }
        
    // MARK: - Create URL
    
    private func createAuthorizeURL(requestToken: String, redirectURI: String?) -> NSURL? {
        let path: String = "\(TMDbAPI.AuthenticateURL)\(requestToken)?redirect_to=\(redirectURI)"
        let url = NSURL(string: path)
        return url
    }

}
