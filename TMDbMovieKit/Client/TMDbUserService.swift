//
//  TMDbUserClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public protocol TMDbUserServiceDelegate: class {
    func user(service: TMDbUserService, didLoadUserInfo user: User)
    func user(service: TMDbUserService, didReceiveError error: TMDbAPIError)
}

public class TMDbUserService {
    
    // MARK: Properties
    
    public weak var delegate: TMDbUserServiceDelegate?
    
    private let sessionInfoProvider: SessionInfoContaining
    
    // MARK: Initialize
    
    public init() {
        self.sessionInfoProvider = TMDbSessionInfoStore()
    }
    
    // MARK: API Calls 
    
    public func getUserInfo() {
        guard let sessionID = sessionInfoProvider.sessionID else {
            self.delegate?.user(self, didReceiveError: .NotAuthorized)
            return 
        }
        
        let paramaters: [String: AnyObject] = ["session_id": sessionID]
        let endpoint = "account"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: paramaters))
            .validate().responseObject { (response: Response<User, NSError>) in
                
                guard response.result.error == nil else {
                    self.handleError(response.result.error!)
                    return
                }
                
                if let user = response.result.value {
                    self.sessionInfoProvider.saveUser(user)
                    self.delegate?.user(self, didLoadUserInfo: user)
                }
        }
    }
    
    // MARK: Error Handling
        
    func handleError(error: NSError) {
        var newError: TMDbAPIError
        
        if error.code == NSURLErrorNotConnectedToInternet {
            newError = .NoInternetConnection
        } else if error.code == NSURLErrorUserAuthenticationRequired {
            newError = .NotAuthorized
        } else {
            newError = .Generic
        }
        
        delegate?.user(self, didReceiveError: newError)
    }
        
}


