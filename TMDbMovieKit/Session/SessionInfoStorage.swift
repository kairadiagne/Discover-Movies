//
//  SessionInfoStorage.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol SessionInfoContaining: class {
    var accessToken: String? { get }
    var sessionID: String? { get}
    func saveSessionID(_ sessionID: String)
    func clearUserData()
}

final class SessionInfoStorage: SessionInfoContaining {
    
    // MARK: - Types
    
    struct Keys {
        static let UserAccount = "User"
        static let SessionID = "sessionID"
    }

    // MARK: - Properties

    var accessToken: String? {
        return nil
    }

    var sessionID: String? {
        return keyValueStorage.object(forKey: Keys.SessionID) as? String
    }

    private let keyValueStorage: KeyValueStorage

    // MARK: - Initialize

    init(keyValueStorage: KeyValueStorage) {
        self.keyValueStorage = keyValueStorage
    }

    func clearUserData() {
        keyValueStorage.set(nil, forKey: Keys.SessionID)
    }
    
    // MARK: - SessionID
    
    func saveSessionID(_ sessionID: String) {
        keyValueStorage.set(sessionID, forKey: Keys.SessionID)
    }
}
