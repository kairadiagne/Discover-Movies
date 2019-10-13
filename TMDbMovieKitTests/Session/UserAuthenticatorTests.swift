//
//  UserAuthenticatorTests.swift
//  
//
//  Created by Kaira Diagne on 12/10/2019.
//

import XCTest
import Mocker
import SafariServices
@testable import TMDbMovieKit
//
//final class UserAuthenticatorTests: BaseTestCase {
//
//    private var sut: UserAuthenticator!
//    private var sessionStorageMock: SessionStorageMock!
//    private var delegateCapturer: UserAuthentingDelegateCapturer!
//
//    override func setUp() {
//        super.setUp()
//
//        sessionStorageMock = SessionStorageMock()
//        delegateCapturer = UserAuthentingDelegateCapturer()
//    }
//
//    override func tearDown() {
//        sut = nil
//        sessionStorageMock = nil
//        delegateCapturer = nil
//
//
//        super.tearDown()
//    }
//
////    /// It should notify the delegate to present the authentication view controller after it succesfully obtained an request token.
////    func testNotifyDelegateWhenRequestTokenLoaded() throws {
////        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager)
////        try Mock(apiRequest: ApiRequest.requestToken(), statusCode: 200, data: MockedData.requestTokenResponse).register()
////
////        sut.authenticate(delegate: delegateCapturer)
////
////        expectation(for: NSPredicate(format: "presentCallCount == 1"), evaluatedWith: delegateCapturer, handler: nil)
////        waitForExpectations(timeout: 3.0, handler: nil)
////    }
////
////    /// It should notify the delegate with an appropriate error when the request to obtain a request token failed.
////    func testNotifyDelegateWhenRequestTokenRequestFailed() throws {
////        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager)
////        try Mock(apiRequest: ApiRequest.requestToken(), statusCode: 404, data: Data()).register()
////
////        sut.authenticate(delegate: delegateCapturer)
////
////        expectation(for: NSPredicate(format: "didFinishAuthenticationCallCount == 1"), evaluatedWith: delegateCapturer, handler: nil)
////        waitForExpectations(timeout: 3.0, handler: nil)
////        XCTAssertNotNil(delegateCapturer.authenticationResult?.error)
////    }
////
////    /// It should call in to the session storage to persist the session ID on success.
////    func testStoresSessionIDWhenRequestSucceeds() throws {
////        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager)
////        try Mock(apiRequest: ApiRequest.requestToken(), statusCode: 200, data: MockedData.requestTokenResponse).register()
////        try Mock(apiRequest: ApiRequest.requestSessionToken(token: <#T##String#>), statusCode: 200, data: MockedData.requestSessionID).register()
////
////        expectation(for: NSPredicate(format: "presentCallCount == 1"), evaluatedWith: delegateCapturer, handler: nil)
////        waitForExpectations(timeout: 3.0, handler: nil)
////
////        sut.safariViewControllerDidFinish(delegateCapturer.authViewController!)
////
////        XCTAssertNil(delegateCapturer.authenticationResult?.error)
////        XCTAssertEqual(sessionStorageMock.saveSessionIDCallCount, 1)
////    }
////
////    /// It should notify the delegate that authentication was succesfully after the session ID is stored.
////    func testNotifyDelegateWhenRequestSucceeds() {
////
////    }
////
////    /// It should notify the delegate that authentication has failed if it could not retrieve a session token.
////    func testNotifyDelegateWhenSessionTokenRequestFails() {
////
////    }
//}
//
//final class SessionStorageMock: SessionInfoContaining {
//
//    private(set) var saveSessionIDCallCount = 0
//    private(set)var sessionID: String?
//
//    func saveSessionID(_ sessionID: String) {
//        saveSessionIDCallCount += 1
//    }
//
//    // TODO: - Refractor the SessionStorage to be a TokenStorage
//    var user: User?
//
//    func clearUserData() {
//    }
//}
//
//final class UserAuthentingDelegateCapturer: NSObject, UserAuthenticatingDelegate {
//
//    @objc private(set) var presentCallCount = 0
//    @objc private(set) var didFinishAuthenticationCallCount = 0
//    @objc private(set) var authViewController: SFSafariViewController?
//    private(set) var authenticationResult: Result<Void, Error>?
//
//    func present(authenticationController: UIViewController) {
//        presentCallCount += 1
//        authViewController = authenticationController as? SFSafariViewController
//    }
//
//    func didFinishAuthentication(with result: Result<Void, Error>) {
//        didFinishAuthenticationCallCount += 1
//        authenticationResult = result
//    }
//}
