//
//  TMDbUserManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation


public class TMDbUserManager {
    
    public var user: TMDbUser? {
        return sessionInfoStore.user
    }
    
    public init() { }
    
    private let userClient = TMDbUserClient()
    
    private let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: - Fetching
    
    public func loadUserInfo() {
        userClient.fetchUserInfo { (user, error) in
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            if let user = user {
                self.sessionInfoStore.persistUserInStore(user)
                self.postUpdateNotification()
            }
        }
    }
    
    // MARK: - Notifications
    
    private func postUpdateNotification() {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbManagerDataDidUpdateNotification, object: self)
    }
    
    private func postErrorNotification(error: NSError) {
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(TMDbManagerDidReceiveErrorNotification, object: self, userInfo: ["error": error])
    }
    
}