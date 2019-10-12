//
//  TMDbSessionInfoStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol SessionInfoContaining: class {
    var user: User? { get set }
    var sessionID: String? { get}
    func clearUserData()
    func saveSessionID(_ sessionID: String)
}

final class SessionInfoStorage: SessionInfoContaining {
    
    // MARK: - Types
    
    struct Keys {
        static let UserAccount = "User"
        static let SessionID = "sessionID"
        static let User = "user"
    }

    // MARK: - Properties

    private let keyValueStorage: KeyValueStorage

    // MARK: - Initialize

    init(keyValueStorage: KeyValueStorage) {
        self.keyValueStorage = keyValueStorage
    }
    
    // MARK: - User
    
    var user: User? {
        get {
            return nil
        } set {
            print(newValue)
        }
    }
    
    func clearUserData() {
    }
    
    // MARK: - SessionID
    
    var sessionID: String? {
        // TODO: - Write a test for migration of locksmith keychain implementation and new implementation
        return nil
    }
    
    func saveSessionID(_ sessionID: String) {
    }
}
