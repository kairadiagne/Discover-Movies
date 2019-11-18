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
    }
    
    public var currentState: SessionState {
        return sessionInfoStorage.accessToken != nil ? .loggedIn : .loggedOut
    }

    private let sessionInfoStorage: AccessTokenManaging

    // MARK: - Initialize

    public convenience init() {
        self.init(storage: AccessTokenStore())
    }
    
    init(storage: AccessTokenStore) {
        self.sessionInfoStorage = storage
    }
}
