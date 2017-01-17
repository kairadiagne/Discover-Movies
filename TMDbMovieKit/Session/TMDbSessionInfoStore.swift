//
//  TMDbSessionInfoStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Locksmith

class TMDbSessionInfoStore: SessionInfoContaining {
    
    // MARK: - Types
    
    struct Keys {
        static let UserAccount = "User"
        static let SessionID = "sessionID"
        static let User = "user"
        static let APIKey = "APIKey"
    }
    
    // MARK: - APIKey
    
    var APIKey: String {
        return UserDefaults.standard.string(forKey: Keys.APIKey) ?? ""
    }
    
    func saveAPIKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: Keys.APIKey)
    }
    
    // MARK: - User
    
    var user: User? {
        get {
            guard let userDict = UserDefaults.standard.object(forKey: Keys.User) as? [String: AnyObject] else { return nil }
            return User(dictionary: userDict)
        } set {
            if newValue != nil {
                UserDefaults.standard.set(newValue!.dictionaryRepresentation(), forKey: Keys.User)
            } else {
                UserDefaults.standard.set([:], forKey: Keys.User)
            }
        }
    }
    
    func save(user: User) {
        self.user = user
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
