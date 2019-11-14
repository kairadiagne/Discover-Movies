//
//  UserAuthenticatorTests.swift
//  
//
//  Created by Kaira Diagne on 12/10/2019.
//

import XCTest
import Mocker
import AuthenticationServices
@testable import TMDbMovieKit

final class UserAuthenticatorTests: BaseTestCase {

    private var sut: UserAuthenticator!
    private var sessionStorageMock: SessionStorageMock!
    private var authenticationContextProviderMock: AuthenticationContextProviderMock!

    private lazy var redirectScheme = "redirect:"
    private lazy var requestToken = "eyJhbGcizI1NiIsInRddddd5cCI6IkpXVCJ9"

    override func setUp() {
        super.setUp()

        sessionStorageMock = SessionStorageMock()
        authenticationContextProviderMock = AuthenticationContextProviderMock()
    }

    override func tearDown() {
        sut = nil
        sessionStorageMock = nil
        authenticationContextProviderMock = nil
        AuthenticationSessionMock.reset()

        super.tearDown()
    }

    /// It should complete with an error when it fails to retrieve a request token.
    func testCompletesWithErrorWhenRequestTokenFails() throws {
        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager)
        try Mock(apiRequest: ApiRequest.requestToken(redirectURL: redirectScheme), statusCode: 401, data: Data()).register()

        let expectation = self.expectation(description: "It should complete with an error")

        sut.authenticate(callbackURLScheme: redirectScheme, presentationContextprovider: authenticationContextProviderMock) { result in
            XCTAssertNotNil(result.error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    /// It should start an authentication session after obtaining a request token.
    func testStartsAuthenticationSessionWhenObtainedRequestToken() throws {
        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager, authenticationSessionFactory: AuthenticationSessionMock.init)
        try Mock(apiRequest: ApiRequest.requestToken(redirectURL: redirectScheme), statusCode: 200, data: MockedData.requestTokenResponse).register()

        let expectation = self.expectation(description: "It should complete with an error")

        sut.authenticate(callbackURLScheme: redirectScheme, presentationContextprovider: authenticationContextProviderMock) { result in
            XCTAssertNotNil(result.error)
            XCTAssertEqual(AuthenticationSessionMock.url?.absoluteString, "https://www.themoviedb.org/auth/access?request_token=\(self.requestToken)")
            XCTAssertEqual(AuthenticationSessionMock.callBackURLScheme, self.redirectScheme)
            XCTAssertEqual(AuthenticationSessionMock.presentationContextProviderCallCount, 1)
            XCTAssertEqual(AuthenticationSessionMock.startCallCount, 1)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    /// It should complete with an appropiate error when the authentication session gets cancelled.
    func testCompletesWithErrorWhenCancelled() throws {
        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager, authenticationSessionFactory: AuthenticationSessionMock.init)
        try Mock(apiRequest: ApiRequest.requestToken(redirectURL: redirectScheme), statusCode: 200, data: MockedData.requestTokenResponse).register()
        AuthenticationSessionMock.errorToReturn = ASWebAuthenticationSessionError(.canceledLogin)

        let expectation = self.expectation(description: "It should complete with an error")

        sut.authenticate(callbackURLScheme: redirectScheme, presentationContextprovider: authenticationContextProviderMock) { result in
            XCTAssertEqual(result.error as? UserAuthenticator.Error, .cancelled)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    /// It should complete with an error when the call back scheme is not recognized.
    func testCompletesWithErrorWhenCallBackSchemeIsNotRecognized() throws {
        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager, authenticationSessionFactory: AuthenticationSessionMock.init)
        try Mock(apiRequest: ApiRequest.requestToken(redirectURL: redirectScheme), statusCode: 200, data: MockedData.requestTokenResponse).register()
        AuthenticationSessionMock.urlToReturn = URL(string: "wrongscheme:")

        let expectation = self.expectation(description: "It should complete with an error")

        sut.authenticate(callbackURLScheme: redirectScheme, presentationContextprovider: authenticationContextProviderMock) { result in
            XCTAssertEqual(result.error as? UserAuthenticator.Error, .generic)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    /// It should request and store an access token when the flow succeeds.
    func testStoresAccessTokenWhenFlowSucceeds() throws {
        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager, authenticationSessionFactory: AuthenticationSessionMock.init)
        try Mock(apiRequest: ApiRequest.requestToken(redirectURL: redirectScheme), statusCode: 200, data: MockedData.requestTokenResponse).register()
        try Mock(apiRequest: ApiRequest.createAccessToken(requestToken: requestToken), statusCode: 200, data: MockedData.accessTokenResponse).register()
        AuthenticationSessionMock.urlToReturn = URL(string: redirectScheme)

        let expectation = self.expectation(description: "It should complete with an error")

        sut.authenticate(callbackURLScheme: redirectScheme, presentationContextprovider: authenticationContextProviderMock) { result in
            XCTAssertNil(result.error)
            XCTAssertEqual(self.sessionStorageMock.storeAccessTokenCallCount, 1)
            XCTAssertEqual(self.sessionStorageMock.accessToken, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYmYiOjE1NzEzNDkwNzcsInN1YiI6IjU4NjEzYjZiOTI1MTQxMTViZTAyZWZkZiIsImp0aSI6IjE2MDcyODIiLCJhdWQiOiJiMjNiMGFkN2E2YzExNjQwZTRlMjMyNTI3ZjJlNmQ2NyIsInNjb3BlcyI6WyJhcGlfcmVhZCIsImFwaV93cml0ZSJdLCJ2ZXJzaW9uIjoxfQ.ScEaszTc_hVhuReYhP6bOfHoAFJxNmqrotvUHEl10I4")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }

    /// It should complete with an error if it can't retrieve an accss token.
    func testCompletesWithErrorWhenAccessTokenRequestFails() throws {
        sut = UserAuthenticator(sessionInfoStorage: sessionStorageMock, sessionManager: sessionManager, authenticationSessionFactory: AuthenticationSessionMock.init)
        try Mock(apiRequest: ApiRequest.requestToken(redirectURL: redirectScheme), statusCode: 200, data: MockedData.requestTokenResponse).register()
        try Mock(apiRequest: ApiRequest.createAccessToken(requestToken: requestToken), statusCode: 401, data: Data()).register()
        AuthenticationSessionMock.urlToReturn = URL(string: redirectScheme)

        let expectation = self.expectation(description: "It should complete with an error")

        sut.authenticate(callbackURLScheme: redirectScheme, presentationContextprovider: authenticationContextProviderMock) { result in
            XCTAssertNotNil(result.error)
            XCTAssertEqual(self.sessionStorageMock.storeAccessTokenCallCount, 0)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
    }
}

final class AuthenticationSessionMock: ASWebAuthenticationSession {

    private(set) static var url: URL?
    private(set) static var callBackURLScheme: String?
    private(set) static var completionHandler: ASWebAuthenticationSession.CompletionHandler?
    private(set) static var startCallCount = 0
    private(set) static var presentationContextProviderCallCount = 0

    static var urlToReturn: URL?
    static var errorToReturn: ASWebAuthenticationSessionError?

    override var presentationContextProvider: ASWebAuthenticationPresentationContextProviding? {
        didSet {
            AuthenticationSessionMock.presentationContextProviderCallCount += 1
        }
    }

    override init(url URL: URL, callbackURLScheme: String?, completionHandler: @escaping ASWebAuthenticationSession.CompletionHandler) {
        super.init(url: URL, callbackURLScheme: callbackURLScheme, completionHandler: completionHandler)
        AuthenticationSessionMock.url = URL
        AuthenticationSessionMock.callBackURLScheme = callbackURLScheme
        AuthenticationSessionMock.completionHandler = completionHandler
    }

    override func start() -> Bool {
        AuthenticationSessionMock.startCallCount += 1
        AuthenticationSessionMock.completionHandler?(AuthenticationSessionMock.urlToReturn, AuthenticationSessionMock.errorToReturn)
        return true
    }

    static func reset() {
        AuthenticationSessionMock.url = nil
        AuthenticationSessionMock.callBackURLScheme = nil
        AuthenticationSessionMock.completionHandler = nil
        AuthenticationSessionMock.startCallCount = 0
        AuthenticationSessionMock.urlToReturn = nil
        AuthenticationSessionMock.errorToReturn = nil
        AuthenticationSessionMock.presentationContextProviderCallCount = 0

    }
}

final class SessionStorageMock: AccessTokenStoring {

    private(set) var storeAccessTokenCallCount = 0
    private(set) var deleteAccessTokenCallCount = 0
    private(set) var accessToken: String?

    func storeAccessToken(_ accessToken: String) {
        storeAccessTokenCallCount += 1
        self.accessToken = accessToken
    }

    func deleteAccessToken() {
        deleteAccessTokenCallCount += 1
    }
}

final class AuthenticationContextProviderMock: NSObject, ASWebAuthenticationPresentationContextProviding {

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIWindow()
    }
}
