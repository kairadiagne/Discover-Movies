//
//  UserAuthenticator.swift
//  ExampleProject
//
//  Created by Kaira Diagne on 28-05-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Alamofire
import SafariServices

/*
 TMDb authentication workflow:

 - Step 1: Create a new request token: This is a temporary token that is required to ask the user for permission to access their account.
 You can generate any number of request tokens but hey will expire after 60 minutes. As soon as a valid sessionID has been created the token
 will be destroyed.

 - Step 2: Ask the user for permission via the website:open .
 The next step is to take the token you got from step 1 and direct your use to the following URL:
 https://www.themoviedb.org/authenticate/REQUEST_TOKen
 The callback URL is also accessible via the Authentication-Callback header that gets returned.
 You can also pass in a redirect_param when making this call which will redirect the user once the authentication flow has been completed.

 - Step 3: Create a session ID: Assuming the reques token was authorized in step 2, you can nog go and request a session ID.
 The results of this query will return a session_id value. This is the value required in all of the write methods.
 */

public protocol UserAuthenticatingDelegate: class {

    /// Asks the delegate to present the authentication controller used for the login.
    /// - Parameter authenticationController: The authentication controller to present.
    func present(authenticationController: UIViewController)

    /// Asks the delegate to handle the result of the login.
    /// - Parameter result: A success or error result of the login.
    func didFinishAuthentication(with result: Swift.Result<Void, Error>)
}

public protocol UserAuthenticating: class {

    /// Starts the flow of authenticating with the Movie Database webservice.
    /// - Parameter delegate: The delegate object responsible for presenting the auth view controller , usually a view controller.
    func authenticate(delegate: UserAuthenticatingDelegate)
}

/// The `UserAuthenticator` class is responsible for handling login with a The Movie Database account.
public final class UserAuthenticator: NSObject, UserAuthenticating {

    // MARK: - Properties

    /// The delegate object responsible for presenting and dismissing the authentication view controller in the login process.
    private weak var delegate: UserAuthenticatingDelegate?

    /// The session manager responsible for handling the API requests.
    private let sessionManager: SessionManager

    /// The session storage used to persist the session ID.
    private let sessionStorage: SessionInfoContaining

    /// The request token used to obtain a session token
    private var requestToken: RequestToken?

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

    public func authenticate(delegate: UserAuthenticatingDelegate) {
        self.delegate = delegate

        sessionManager.request(ApiRequest.requestToken()).validate().responseObject { (response: DataResponse<RequestToken>) in
            switch response.result {
            case .success(let token):
                self.showSafariViewController(requestToken: token)
            case .failure(let error):
                delegate.didFinishAuthentication(with: .failure(error))
            }
        }
    }

    // MARK: Utils

    private func showSafariViewController(requestToken: RequestToken) {
        guard let url = try? ApiRequest.authenticate(token: requestToken.token).asURLRequest().url else {
            delegate?.didFinishAuthentication(with: .failure(APIError.generic))
            return
        }

        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = self
        delegate?.present(authenticationController: safariViewController)
    }

    private func requestSessionToken(requestToken: RequestToken) {
        let sessionTokenRequest = ApiRequest.requestSessionToken(token: requestToken.token)

        sessionManager.request(sessionTokenRequest).validate().responseObject { (response: DataResponse<SessionToken>) in
            switch response.result {
            case .success(let token):
                self.sessionStorage.saveSessionID(token.sessionID)
                self.delegate?.didFinishAuthentication(with: .success(()))
            case .failure(let error):
                self.delegate?.didFinishAuthentication(with: .failure(error))
            }
        }
    }
}

extension UserAuthenticator: SFSafariViewControllerDelegate {

    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        guard let requestToken = requestToken else {
            delegate?.didFinishAuthentication(with: .failure(APIError.generic))
            return
        }

        requestSessionToken(requestToken: requestToken)
    }
}
