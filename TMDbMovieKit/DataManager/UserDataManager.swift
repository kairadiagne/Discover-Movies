//
//  UserManager.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 28-05-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public protocol TMDbUserServiceDelegate: class {
    func user(service: UserDataManager, didLoadUserInfo user: User)
    func user(service: UserDataManager, didFailWithError error: APIError)
}

public final class UserDataManager {

    // MARK: - Properties

    public var user: User? {
        return sessionInfo.user
    }

    public weak var delegate: TMDbUserServiceDelegate?

    private var sessionInfo: SessionInfoContaining

    private let apiService: APIService

    // MARK: - Initialize

    init(apiService: APIService, sessionInfo: SessionInfoContaining) {
        self.apiService = apiService
        self.sessionInfo = sessionInfo
    }

    public init() {
        self.apiService = APIService()
        self.sessionInfo = SessionInfoService.shared
    }

    // MARK: - API Calls

    public func getUserInfo() {
        guard let sessionID = sessionInfo.sessionID else {
            self.delegate?.user(service: self, didFailWithError: .unAuthorized)
            return
        }

        let requestBuilder = RequestBuilder.user(sessionID: sessionID)

        apiService.executeRequest(builder: requestBuilder) { (response: APIResult<User>) in
            switch response {
            case .success(let user):
                self.sessionInfo.user = user
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
