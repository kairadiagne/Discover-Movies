//
//  TMDbSessionInfoStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Locksmith

protocol SessionInfoContaining {
    var sessionID: String? { get }
    var user: User? { get }
    var APIKey: String { get }
    func saveSessionID(sessionID: String)
    func saveUser(user: User)
    func clearUserData()
    func saveAPIKey(key: String)
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
        return Locksmith.loadDataForUserAccount(Keys.UserAccount)?[Keys.SessionID] as? String
    }
    
    var user: User? {
        guard let userDict = Locksmith.loadDataForUserAccount(Keys.UserAccount)?[Keys.User] as? [String: AnyObject] else { return nil }
        return User(dictionary: userDict)
    }
    
    var APIKey: String {
        return  NSUserDefaults.standardUserDefaults().stringForKey(Keys.APIKey) ?? ""
    }
    
    private let writeQueue = dispatch_queue_create("com.discoverMovies.app.write", DISPATCH_QUEUE_SERIAL)
    
    // MARK: - Persistence
    
    func saveSessionID(sessionID: String) {
        do {
            try Locksmith.updateData([Keys.SessionID: sessionID], forUserAccount: Keys.UserAccount)
        } catch {
            print("Error saving sessionID from keychain")

        }
    }
    
    func saveUser(user: User) {
        do {
            try Locksmith.updateData([Keys.User: user.dictionaryRepresentation()], forUserAccount: Keys.UserAccount)
        } catch {
            print("Error saving user to keychain")
        }
    }
    
    func saveAPIKey(key: String) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(key, forKey: Keys.APIKey)
    }
    
    // MARK: - Clear
    
    func clearUserData() {
        do {
            try Locksmith.deleteDataForUserAccount(Keys.UserAccount)
        } catch {
            print("Error deleteing user data from store")
        }
    }
    
}

