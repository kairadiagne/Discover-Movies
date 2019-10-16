//
//  UserAuthenticator.swift
//  ExampleProject
//
//  Created by Kaira Diagne on 28-05-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Alamofire
import AuthenticationServices

/// An interface describing a type which is responsible for loging in a user with their the Movie Database account.
public protocol UserAuthenticating: class {

    typealias AuthenticationCallBack = (Swift.Result<Void, Error>) -> Void

    /// Starts the flow of authenticating with the Movie Database webservice.
    /// - Parameter callbackURLScheme: The redirect URL used to redirect to the app after authentication.
    /// - Parameter presentationContextprovider: The window in which the authentication UI should be presented.
    /// - Parameter completion: The completion handler called when authentication has succeded or failed.
    func authenticate(callbackURLScheme: String, presentationContextprovider: ASWebAuthenticationPresentationContextProviding, completion: @escaping AuthenticationCallBack)
}

public final class UserAuthenticator: NSObject, UserAuthenticating {

    enum Error: Swift.Error {

        /// The user cancelled the authentication flow.
        case cancelled

        /// A generic error in case the error is not cancelled or api related.
        case generic
    }

    // MARK: - Properties

    /// The session manager responsible for handling the API requests.
    private let sessionManager: SessionManager

    /// The authentication session that handles the approval of the request ID for the MovieDB
    private var authenticationSession: ASWebAuthenticationSession?

    /// The session storage used to persist the session ID.
    private let sessionStorage: SessionInfoContaining

    // MARK: - Initialize

    public convenience override init() {
        let storage = SessionInfoStorage(keyValueStorage: UserDefaults.standard)
        let sessionManager = DiscoverMoviesKit.shared.sessionManager
        self.init(sessionInfoStorage: storage, sessionManager: sessionManager)
    }

    init(sessionInfoStorage: SessionInfoContaining, sessionManager: SessionManager) {
        self.sessionStorage = sessionInfoStorage
        self.sessionManager = sessionManager
    }

    // MARK: UserAuthenticating

    public func authenticate(callbackURLScheme: String, presentationContextprovider: ASWebAuthenticationPresentationContextProviding, completion: @escaping AuthenticationCallBack) {
        let request = ApiRequest.requestToken(redirectURL: callbackURLScheme)

        sessionManager.request(request).validate().responseObject { [weak self] (response: DataResponse<RequestToken>) in
            guard let self = self else { return }

            switch response.result {
            case .success(let token):
                self.startAuthenticationSession(callBackURLScheme: callbackURLScheme, presentationContextProvier: presentationContextprovider, requestToken: token, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func startAuthenticationSession(callBackURLScheme: String, presentationContextProvier: ASWebAuthenticationPresentationContextProviding, requestToken: RequestToken, completion: @escaping AuthenticationCallBack) {
        guard let authenticationURL = URL(string: "https://www.themoviedb.org/auth/access?request_token=\(requestToken.value)") else {
            completion(.failure(Error.generic))
            return
        }

        authenticationSession = ASWebAuthenticationSession(url: authenticationURL, callbackURLScheme: callBackURLScheme) { [weak self] url, error in
            guard let self = self else { return }

            if let error = error as? ASWebAuthenticationSessionError, error.code == .canceledLogin {
                completion(.failure(Error.cancelled))
            } else if url?.absoluteString == callBackURLScheme {
                self.requestAccessToken(requestToken: requestToken, completion: completion)
            } else {
                completion(.failure(Error.generic))
            }

            self.authenticationSession = nil
        }

        authenticationSession?.presentationContextProvider = presentationContextProvier
        authenticationSession?.start()
    }

    private func requestAccessToken(requestToken: RequestToken, completion: @escaping AuthenticationCallBack) {
        let accessTokenRequest = ApiRequest.createAccessToken(requestToken: requestToken.value)

        sessionManager.request(accessTokenRequest).validate().responseObject { (response: DataResponse<AccessToken>) in
            switch response.result {
            case .success(let token):
                self.sessionStorage.saveSessionID(token.value)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
