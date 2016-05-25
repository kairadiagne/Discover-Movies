//
//  TMDbSignInClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

class TMDbSignInClient: TMDbAPIClient {
    
    private var requestToken: TMDbRequestToken?
    
    // MARK: - Sign In
    
    // Generates a valid request token for user based authentication
    
    func getRequestToken(completionHandler: (url: NSURL?, error: NSError?) -> Void) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["api_key"] = APIKey
        
        let url = URL.Base + "authentication/token/new"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
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
        
        var parameters: [String: AnyObject] = [:]
        parameters["api_key"] = APIKey
        parameters["request_token"] = requestToken?.token ?? ""
        
        let url = URL.Base + "authentication/session/new"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
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

