//
//  TMDbSignInManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

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

public protocol TMDbSignInDelegate: class {
    func signIn(service: TMDbSignInService, didReceiveAuthorizationURL url: NSURL)
    func signIn(service: TMDbSignInService, didFailWithError error: TMDbAPIError)
    func signInServiceDidSignIn(service: TMDbSignInService)
}

public class TMDbSignInService: ErrorHandling {
    
    // MARK: - Properties
    
    public weak var delegate: TMDbSignInDelegate?
    
    private var isLoading = false
    
    private let sessionInfoProvider: SessionInfoContaining
    
    private var token: RequestToken?
    
    // MARK: Initialize
    
    public init() {
        self.sessionInfoProvider = TMDbSessionInfoStore()
    }
    
    // MARK: - Sign In 
    
    public func requestToken() {
        let endPoint = "authentication/token/new"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endPoint, parameters: [:]))
            .validate().responseObject { (response: Response<RequestToken, NSError>) in
                
                guard response.result.error == nil else {
                    let error = self.categorizeError(response.result.error!)
                    self.delegate?.signIn(self, didFailWithError: error)
                    return
                }
                
                if let requestToken = response.result.value {
                    self.token = requestToken
                    
                    let path: String = "\(TMDbAPI.AuthenticateURL)\(requestToken.token)"
                    
                    if let url = NSURL(string: path) {
                        self.delegate?.signIn(self, didReceiveAuthorizationURL: url)
                    } else {
                        self.delegate?.signIn(self, didFailWithError: .Generic)
                    }
                }
        }
    }
    
    public func requestSessionID() {
        guard let token = token?.token else {
            delegate?.signIn(self, didFailWithError: .Generic)
            return
        }
        
        let paramaters: [String: AnyObject] = ["request_token": token]
        let endPoint = "authentication/session/new"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endPoint, parameters: paramaters))
            .validate().responseJSON { response in
                
                guard response.result.error == nil else {
                    let error = self.categorizeError(response.result.error!)
                    self.delegate?.signIn(self, didFailWithError: error)
                    return
                }
                
                if let sessionID = response.result.value?["session_id"] as? String {
                    self.sessionInfoProvider.saveSessionID(sessionID)
                    self.delegate?.signInServiceDidSignIn(self)
                }
        }
    }

}





