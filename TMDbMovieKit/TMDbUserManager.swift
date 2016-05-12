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
    
    private let userService = TMDbUserService()
    
    private let sessionInfoStore = TMDbSessionInfoStore()
    
    public func reloadIfNeeded(force: Bool) {
        userService.fetchUserInfo { (user, error) in
            guard error != nil else {
                // Error notification
                return
            }
            
            if let user = user {
                self.sessionInfoStore.persistUserInStore(user)
                // Notification
            }
        }
    }
    
}