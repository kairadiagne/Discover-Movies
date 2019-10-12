//
//  UserAuthenticatorTests.swift
//  
//
//  Created by Kaira Diagne on 12/10/2019.
//

import XCTest
@testable import TMDbMovieKit

final class UserAuthenticatorTests: XCTestCase {

    private var sessionStorageMock: SessionStorageMock!
    private var delegateCapturer: UserAuthentingDelegateCapturer!

    override func setUp() {
        super.setUp()

        sessionStorageMock = SessionStorageMock()
        delegateCapturer = UserAuthentingDelegateCapturer()
    }

    override func tearDown() {
        sessionStorageMock = nil
        delegateCapturer = nil

        super.tearDown()
    }

    /// It should notify the delegate to present the authentication view controller after it succesfully obtained an request token.
    func testNotifyDelegateWhenRequestTokenLoaded() {

    }

    /// It should notify the delegate with an appropriate error when the request to obtain a request token failed.
    func testNotifyDelegateWhenRequestTokenRequestFailed() {

    }

    /// It should attempt to request a session token when the safari view controller did finish.
    func testRequestsSessionTokenWhenSafariViewControllerFinished() {

    }

    /// It should call in to the session storage to persist the session ID on success.
    func testStoresSessionIDWhenRequestSucceeds() {

    }

    /// It should notify the delegate that authentication was succesfully after the session ID is stored.
    func testNotifyDelegateWhenRequestSucceeds() {

    }

    /// It should notify the delegate that authentication has failed if it could not retrieve a session token.
    func testNotifyDelegateWhenSessionTokenRequestFails() {

    }
}

final class SessionStorageMock: SessionInfoContaining {

    private(set) var saveSessionIDCallCount = 0
    private(set)var sessionID: String?

    func saveSessionID(_ sessionID: String) {
        saveSessionIDCallCount += 1
    }

    // TODO: - Refractor the SessionStorage to be a TokenStorage
    var user: User?

    func clearUserData() {
    }
}

final class UserAuthentingDelegateCapturer: UserAuthenticatingDelegate {

    private(set) var presentCallCount = 0
    private(set) var didFinishAuthenticationCallCount = 0
    private(set) var authenticationResult: Result<Void, Error>?

    func present(authenticationController: UIViewController) {
        presentCallCount += 1
    }

    func didFinishAuthentication(with result: Result<Void, Error>) {
        didFinishAuthenticationCallCount += 1
        authenticationResult = result
    }
}
