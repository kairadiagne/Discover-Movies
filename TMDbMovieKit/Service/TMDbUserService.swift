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
            self.delegate?.user(service: self, didFailWithError: .unAuthorized)
            return 
        }
        
        let paramaters: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        let endpoint = "account"
        
        Alamofire.request(APIRouter.get(endpoint: endpoint, queryParams: paramaters))
            .validate().responseObject { (response: DataResponse<User>) in
                
                switch response.result {
                case .success(let user):
                    self.sessionInfoProvider.saveUser(user)
                    self.delegate?.user(service: self, didLoadUserInfo: user)
                case .failure(let error):
                    let error = self.errorHandler.categorize(error: error)
                    self.delegate?.user(service: self, didFailWithError: error)
                }

        }
    }
        
}


