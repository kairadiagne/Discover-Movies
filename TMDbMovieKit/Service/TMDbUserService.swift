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
    
    fileprivate let configuration: UserConfiguration
    
    // MARK: - Initialize
    
    public init() {
        self.sessionInfoProvider = TMDbSessionInfoStore()
        self.errorHandler = APIErrorHandler()
        self.configuration = UserConfiguration()
    }
    
    // MARK: - API Calls
    
    public func getUserInfo() {
        guard let sessionID = sessionInfoProvider.sessionID else {
            self.delegate?.user(service: self, didFailWithError: .unAuthorized)
            return 
        }
        
        let params: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        Alamofire.request(APIRouter.request(config: configuration, queryParams: params , bodyParams: nil))
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


