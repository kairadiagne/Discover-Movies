//
//  TMDbSessionInfoStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Locksmith

protocol SessionInfoContaining: class {
    var user: User? { get set }
    func clearUserData()
    var sessionID: String? { get}
    func saveSessionID(_ sessionID: String)
}

final class SessionInfoStorage: SessionInfoContaining {
    
    // MARK: - Types
    
    struct Keys {
        static let UserAccount = "User"
        static let SessionID = "sessionID"
        static let User = "user"
        static let APIKey = "APIKey"
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
//            guard let userDict = keyValueStorage.object(forKey: Keys.User) as? [String: AnyObject] else { return nil }
//            return User(dictionary: userDict)
        } set {
            print(newValue)
//            keyValueStorage.set(newValue?.dictionaryRepresentation(), forKey: Keys.User)
        }
    }
    
    func clearUserData() {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: Keys.UserAccount)
            user = nil
        } catch {
            print("Error deleteing user data from store")
        }
    }
    
    // MARK: - SessionID
    
    var sessionID: String? {
        return Locksmith.loadDataForUserAccount(userAccount: Keys.UserAccount)?[Keys.SessionID] as? String
    }
    
    func saveSessionID(_ sessionID: String) {
        do {
            try Locksmith.saveData(data: [Keys.SessionID: sessionID], forUserAccount: Keys.UserAccount)
        } catch {
            print("Error saving sessionID from keychain")
        }
    }
}
