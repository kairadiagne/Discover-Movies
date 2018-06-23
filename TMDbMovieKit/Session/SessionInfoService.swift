//
//  SessionInfoService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Locksmith

final class SessionInfoService: SessionInfoContaining {
    
    // MARK: - Types
    
    struct Keys {
        static let UserAccount = "User"
        static let SessionID = "sessionID"
        static let User = "user"
        static let APIKey = "APIKey"
    }

    // MARK: - Properties

    let APIKey: String

    var user: User?

    var sessionID: String? {
        // USE keychain api met Data Protection complete
        return Locksmith.loadDataForUserAccount(userAccount: Keys.UserAccount)?[Keys.SessionID] as? String
    }

    // MARK: - Initialize

    static let shared = SessionInfoService()

    init() {
        let path = Bundle(for: type(of: self)).path(forResource: "Keys", ofType: "plist")!
        // swiftlint:disable:next force_cast
        APIKey = NSDictionary(contentsOfFile: path)![Keys.APIKey] as! String
    }

    // MARK: - SessionID

    func saveSessionID(_ sessionID: String) {
        do {
            // USE keychain api met Data Protection complete
            try Locksmith.saveData(data: [Keys.SessionID: sessionID], forUserAccount: Keys.UserAccount)
        } catch {
            print("Error saving sessionID from keychain")
        }
    }

    // MARK: - Clear

    func clearUserData() {
        do {
            try Locksmith.deleteDataForUserAccount(userAccount: Keys.UserAccount)
            user = nil
        } catch {
            print("Error deleteing user data from store")
        }
    }
}
