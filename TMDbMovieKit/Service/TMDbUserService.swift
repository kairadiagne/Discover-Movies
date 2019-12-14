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
    func user(service: TMDbUserService, didLoadUserInfo user: TMDBUser)
    func user(service: TMDbUserService, didFailWithError error: APIError)
}

public final class TMDbUserService {
    
    // MARK: - Properties
    
    public weak var delegate: TMDbUserServiceDelegate?
    
    private let sessionInfoStorage: AccessTokenManaging
    
    // MARK: - Initialize

    public convenience init() {
        self.init(sessionInfoStorage: AccessTokenStore())
    }

    init(sessionInfoStorage: AccessTokenStore) {
        self.sessionInfoStorage = sessionInfoStorage
    }
    
    // MARK: - API Calls
    
    public func getUserInfo() {
        guard let sessionID = sessionInfoStorage.accessToken else {
            self.delegate?.user(service: self, didFailWithError: .unAuthorized)
            return 
        }
        
        Alamofire.request(ApiRequest.getUser(sessionID: sessionID))
            .validate().responseObject { (response: DataResponse<TMDBUser>) in
                
                switch response.result {
                case .success(let user):
//                    self.sessionInfoStorage.user = user
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
