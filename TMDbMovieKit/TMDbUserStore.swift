//
//  TMDbUserInformationStore.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 18-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Locksmith
import Alamofire
import SwiftyJSON

public class TMDbUserStore {
    
    var userService: TMDbUserService!
    
    public var userIsSignedIn: Bool {
        return sessionID != nil ? true: false
    }
    
    public var userIsInPublicMode: Bool {
        set { NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "userIsInpublicMode") }
        get { return NSUserDefaults.standardUserDefaults().boolForKey("userIsInpublicMode") }
    }
    
    public var user: TMDbUser? {
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let data = defaults.objectForKey("user") as? NSData else  { return nil }
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? TMDbUser
    }
    
    var sessionID: String? {
        let dict = Locksmith.loadDataForUserAccount("User")
        return dict?["sessionID"] as? String ?? nil
    }
    
    public func signOutUser() {
        deleteSessionIDFromStore()
        deleteUserFromStore()
    }
    
    public func deleteCredentialsAtFirstLaunch() {
        if sessionID != nil {
            deleteSessionIDFromStore()
        }
    }
    
    public init() {
        self.userService = TMDbUserService()
    }
    
    // MARK: - Persist/ Delete sessionID
    
    func persistSessionIDinStore(sessionID: String) {
        do { try Locksmith.updateData(["sessionID": sessionID], forUserAccount: "User") }
        catch { deleteSessionIDFromStore() }
    }
    
    func deleteSessionIDFromStore() {
        do { try Locksmith.deleteDataForUserAccount("User") }
        catch { print("Error deleting sessionID from store") }
    }
    
    // MARK: - User Information 
    
    public func refreshUserInfo() {
        fetchUserInfo()
    }
    
    func fetchUserInfo() { 
        guard let sessionID = sessionID else { return }
        userService.fetchUserInfo(sessionID) { (response) in
            if let user = response.value {
                self.persistUserInStore(user)
            }
        }
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

}

