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
    func user(service: TMDbUserService, didFailWithError error: APIError)
}

public class TMDbUserService {
    
    // MARK: - Properties
    
    public weak var delegate: TMDbUserServiceDelegate?
    
    fileprivate let sessionInfoProvider: SessionInfoContaining
    
    fileprivate let errorHandler: ErrorHandling
    
    // MARK: - Initialize
    
    public init() {
        self.sessionInfoProvider = TMDbSessionInfoStore()
        self.errorHandler = APIErrorHandler()
    }
    
    // MARK: - API Calls
    
    public func getUserInfo() {
        guard let sessionID = sessionInfoProvider.sessionID else {
            self.delegate?.user(service: self, didFailWithError: .notAuthorized)
            return 
        }
        
        let paramaters: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        let endpoint = "account"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: paramaters))
            .validate().responseObject { (response: Response<User, NSError>) in
                
                guard response.result.error == nil else {
                    let error = self.errorHandler.categorize(error: response.result.error!)
                    self.delegate?.user(service: self, didFailWithError: error)
                    return
                }
                
                if let user = response.result.value {
                    self.sessionInfoProvider.saveUser(user)
                    self.delegate?.user(service: self, didLoadUserInfo: user)
                }
        }
    }
        
}


