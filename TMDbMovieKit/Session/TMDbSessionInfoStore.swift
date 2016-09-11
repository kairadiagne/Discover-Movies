//
//  TMDbSessionInfoStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
//import Locksmith

protocol SessionInfoContaining {
    var sessionID: String? { get }
    var user: User? { get }
    var APIKey: String { get }
    func saveSessionID(_ sessionID: String)
    func saveUser(_ user: User)
    func clearUserData()
    func saveAPIKey(_ key: String)
}

class TMDbSessionInfoStore: SessionInfoContaining {
    
    // MARK: - Types
    
    struct Keys {
        static let UserAccount = "User"
        static let SessionID = "sessionID"
        static let User = "user"
        static let APIKey = "APIKey"
    }
    
    // MARK: - Properties
    
    var sessionID: String? {
        // return Locksmith.loadDataForUserAccount(Keys.UserAccount)?[Keys.SessionID] as? String
        return ""
    }
    
    var user: User? {
        guard let userDict = UserDefaults.standard.object(forKey: Keys.User) as? [String: AnyObject] else { return nil }
        return User(dictionary: userDict)
    }
    
    var APIKey: String {
        return  UserDefaults.standard.string(forKey: Keys.APIKey) ?? ""
    }
    
    // MARK: - Persistence
    
    func saveSessionID(_ sessionID: String) {
        do {
            // try Locksmith.saveData([Keys.SessionID: sessionID], forUserAccount: Keys.UserAccount)
        } catch {
            print("Error saving sessionID from keychain")

        }
    }
    
    func saveUser(_ user: User) {
        UserDefaults.standard.set(user.dictionaryRepresentation(), forKey: Keys.User)
    }
    
    func saveAPIKey(_ key: String) {
        UserDefaults.standard.set(key, forKey: Keys.APIKey)
    }
    
    // MARK: - Clear
    
    func clearUserData() {
        do {
            // try Locksmith.deleteDataForUserAccount(Keys.UserAccount)
        } catch {
            print("Error deleteing user data from store")
        }
    }
    
}
