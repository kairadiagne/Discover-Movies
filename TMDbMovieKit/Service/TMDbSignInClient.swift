//
//  TMDbSignInClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

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

class TMDbSignInClient: TMDbAPIClient {
    
    private var requestToken: TMDbRequestToken?
    
    // Generates a valid request token for user based authentication
    
    func getRequestToken(completionHandler: (url: NSURL?, error: NSError?) -> Void) {
        
        let parameters: [String: AnyObject] = [:]
        
        let endpoint = "authentication/token/new"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbRequestToken, NSError>) in
                
                guard response.result.error == nil else {
                    completionHandler(url: nil, error: response.result.error!)
                    return
                }
                
                if let requestToken = response.result.value {
                    self.requestToken = requestToken
                    
                    let path: String = "\(TMDbAPI.AuthenticateURL)\(requestToken.token)"
                    let url = NSURL(string: path)
    
                    completionHandler(url: url, error: nil)
                }
        }
        
    }
    
    func requestSessionID(completionHandler: (sessionID: TMDbSessionID?, error: NSError?) -> Void) {
        
        guard let requestToken = requestToken?.token else {
            // Return error 
            return
        }
        
        let parameters: [String: AnyObject] = ["request_token": requestToken]
        
        let endpoint = "authentication/session/new"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbSessionID, NSError>) in
                
                guard response.result.error == nil else {
                    completionHandler(sessionID: nil, error: response.result.error!)
                    return
                }
                
                if let sessionID = response.result.value {
                    completionHandler(sessionID: sessionID, error: nil)
                }
        }
        
    }
    
}

