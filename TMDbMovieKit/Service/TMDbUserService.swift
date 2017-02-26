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
    
    private let sessionInfoProvider: SessionInfoContaining
    
    private let configuration: UserConfiguration
    
    // MARK: - Initialize
    
    public init() {
        self.sessionInfoProvider = TMDbSessionInfoStore()
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
                    self.sessionInfoProvider.save(user: user)
                    self.delegate?.user(service: self, didLoadUserInfo: user)
                case .failure(let error):
                    if let error = error as? APIError {
                        self.delegate?.user(service: self, didFailWithError: error)
                    } else {
                        self.delegate?.user(service: self, didFailWithError: .generic)
                    }
                }
        }
    }
        
}
