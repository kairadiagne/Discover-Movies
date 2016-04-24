//
//  TMDbUserInfoStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 18-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Locksmith

public enum TMDBSiginStatus {
    case Signedin
    case PublicMode
    case Unknown
}

public class TMDbUserInfoStore { // SessionInfo

    public var userStatus: TMDBSiginStatus {
        if sessionID != nil { return .Signedin }
        if publicModeActivated { return .PublicMode }
        return .Unknown
    }
    
    public var user: TMDbUser? {
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let data = defaults.objectForKey("user") as? NSData else  { return nil }
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? TMDbUser
    }

    public func signOut() {
        deleteUserFromStore()
        deleteSessionIDFromStore()
    }
    
    public func resetCredentialsAtFirstLaunch() {
        if sessionID != nil { deleteSessionIDFromStore() }
    }
    
    public init() { }
    
    // MARK: - Public mode
    
    var publicModeActivated: Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey("userIsInpublicMode")
    }
    
    public func activatePublicMode() {
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "userIsInpublicMode")
    }
    
    public func deactivatePublicMode() {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "userIsInpublicMode")
    }
    
    // MARK: - User persistence
    
    func persistUserInStore(user: TMDbUser) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        defaults.setObject(data, forKey: "user")
    }
    
    func deleteUserFromStore() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("user")
    }
    
    // MARK: - Credential persistence
    
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
    
}





