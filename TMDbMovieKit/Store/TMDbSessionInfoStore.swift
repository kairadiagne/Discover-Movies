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
    
    // MARK: SessionID
    
    var sessionID: String? {
        let dict = Locksmith.loadDataForUserAccount("User")
        return dict?["sessionID"] as? String ?? nil
    }
    
    func persistSessionIDinStore(sessionID: String) {
        do { try Locksmith.updateData(["sessionID": sessionID], forUserAccount: "User") }
        catch { deleteSessionIDFromStore() }
    }
    
    func deleteSessionIDFromStore() {
        do {
            try Locksmith.deleteDataForUserAccount("User")
        }
        catch {
            print("Error deleting sessionID from store")
        }
    }
    
    // MARK: UserInfo
    
    var user: User? {
        // This should be done of the main thread
        assert(NSThread.isMainThread())
        
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let data = defaults.objectForKey("user") as? NSData else  { return nil }
        guard let userDict = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [String: AnyObject] else { return nil }
        return User(dictionary: userDict)
    }
    
    func persistUserInStore(user: User) {
        // This should be done of the main thread
        assert(NSThread.isMainThread())
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let data = NSKeyedArchiver.archivedDataWithRootObject(user.dictionaryRepresentation())
        defaults.setObject(data, forKey: "user")
    }
    
    func deleteUserFromStore() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("user")
    }
    
    // MARK: APIKey
    
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
