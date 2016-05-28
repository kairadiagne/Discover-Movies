//
//  TMDbSessionInfoStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Locksmith

class TMDbSessionInfoStore {
    
    private let writeQueue = dispatch_queue_create("com.discoverMovies.app.write", DISPATCH_QUEUE_SERIAL)
    
    // MARK: - SessionID
    
    var sessionID: String? {
        let dict = Locksmith.loadDataForUserAccount("User")
        return dict?["sessionID"] as? String ?? nil
    }
    
    func persistSessionIDinStore(sessionID: String) {
        do { try Locksmith.updateData(["sessionID": sessionID], forUserAccount: "User") }
        catch { deleteSessionIDFromStore() }
    }
    
    func deleteSessionIDFromStore() {
        do { try Locksmith.deleteDataForUserAccount("User") }
        catch { print("Error deleting sessionID from store") }
    }
    
    // MARK: - UserInfo
    
    var user: TMDbUser? {
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let data = defaults.objectForKey("user") as? NSData else  { return nil }
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? TMDbUser
    }
    
    func persistUserInStore(user: TMDbUser) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        defaults.setObject(data, forKey: "user")
    }
    
    func deleteUserFromStore() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("user")
    }
    
    // MARK: - APIKey
    
    var APIKey: String {
        set {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newValue, forKey: "APIKey")
        }
        get {
            let defaults = NSUserDefaults.standardUserDefaults()
            guard let key = defaults.stringForKey("APIKey") else { fatalError() }
            return key
        }
    }
    
}
