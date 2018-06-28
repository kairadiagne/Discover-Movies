//
//  AuthenticationManager.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 28-05-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation

/*
 TMDb authentication workflow:

 - Step 1: Create a new request token: This is a temporary token that is required to ask the user for permission to access their account.
 You can generate any number of request tokens but hey will expire after 60 minutes. As soon as a valid sessionID has been created the token
 will be destroyed.

 - Step 2: Ask the user for permission via the website:
 The next step is to take the token you got from step 1 and direct your use to the following URL:
 https://www.themoviedb.org/authenticate/REQUEST_TOKen
 The callback URL is also accessible via the Authentication-Callback header that gets returned.
 You can also pass in a redirect_param when making this call which will redirect the user once the authentication flow has been completed.

 - Step 3: Create a session ID: Assuming the reques token was authorized in step 2, you can nog go and request a session ID.
 The results of this query will return a session_id value. This is the value required in all of the write methods.

 */

public protocol AuthenticationManagerDelegate: class {
    func authenticationManager(_ manager: AuthenticationManager, didReceiveAuthorizationURL url: URL)
    func authenticationManager(_ manager: AuthenticationManager, didFailWithError: APIError)
    func authenticationManagerDidFinish(_ manager: AuthenticationManager)
}

public final class AuthenticationManager {

    public enum AuthenticationState {
        case signedIn
        case signedOut
    }

    // MARK: - Properties

    public var signInStatus: AuthenticationState {
        return sessionInfo.sessionID != nil ? .signedIn : .signedOut
    }

    public weak var delegate: AuthenticationManagerDelegate?

    private let apiService: APIService

    private let sessionInfo: SessionInfoContaining

    private var token: RequestToken?

    // MARK: - Initialize

    public convenience init() {
        self.init()
    }

    init(sessionInfo: SessionInfoContaining = SessionInfoService.shared, apiService: APIService = APIService()) {
        self.sessionInfo = sessionInfo
        self.apiService = apiService
    }

    // MARK: - Sign in

    public func requestToken() {
        let tokenRequestBuilder = RequestBuilder.requestToken()
        apiService.executeRequest(builder: tokenRequestBuilder) { (result: (APIResult<RequestToken>)) in
            switch result {
            case .failure(let error):
                self.delegate?.authenticationManager(self, didFailWithError: error as? APIError ?? .generic)

            case .success(let token):
                self.token = token

                let path: String = "\(TMDbAPI.AuthenticateURL)\(token.token)"

                if let url = URL(string: path) {
                    self.delegate?.authenticationManager(self, didReceiveAuthorizationURL: url)
                } else {
                    self.delegate?.authenticationManager(self, didFailWithError: .generic)
                }
            }
        }
    }

    public func requestSessionToken() {
        guard let requestToken = token?.token else {
            delegate?.authenticationManager(self, didFailWithError: .generic)
            return
        }

        let sessionIDRequestBuilder = RequestBuilder.sessionToken(requestToken: requestToken)
        apiService.executeRequest(builder: sessionIDRequestBuilder) { (result: (APIResult<SessionToken>)) in
            switch result {
            case .failure(let error):
                self.delegate?.authenticationManager(self, didFailWithError: error as? APIError ?? .generic)

            case .success(let token):
                // Persist
                self.sessionInfo.saveSessionID(token.sessionID)

                // Cleanup
                self.token = nil

                // Notify
                self.delegate?.authenticationManagerDidFinish(self)

            }
        }
    }

    // MARK: - Sign out

    public func signOut() {
        sessionInfo.clearUserData()
    }
}
