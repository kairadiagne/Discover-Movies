//
//  UserSessionManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class UserSessionManager {

    public enum SessionState: Equatable {

        /// The user is logged out of the Movie Database.
        case loggedOut

        /// The user is logged in with a the Movie Database account.
        case loggedIn

        public static let sessionStateDidChange = Notification.Name(rawValue: "SessionState")

        /// Posts a notification to notify observers of State change.
        public func post() {
            NotificationCenter.default.post(name: SessionState.sessionStateDidChange, object: self)
        }
    }
    
    public var currentState: SessionState = .loggedOut

    private let sessionInfoStorage: AccessTokenManaging

    // MARK: - Initialize

    public convenience init() {
        self.init(storage: AccessTokenStore())
    }
    
    init(storage: AccessTokenStore) {
        self.sessionInfoStorage = storage

        // Calculate the initial state
        calculateState()
    }

    private func calculateState() {
        let prevState = currentState
        currentState = sessionInfoStorage.accessToken != nil ? .loggedIn : .loggedOut

        guard prevState != currentState else {
            return
        }

        /// Notify all observers about the state change. 
        currentState.post()
    }
}
