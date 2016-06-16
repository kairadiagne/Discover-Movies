//
//  TMDbUserManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbUserManager: TMDbBaseDataManager {
    
    // MARK: Properties
    
    public var user: TMDbUser? {
        return sessionInfoStore.user
    }
    
    private let userClient = TMDbUserClient()
    
    private let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: - Fetching
    
    public func loadUserInfo() {
        isLoading = true
        
        userClient.fetchUserInfo { (user, error) in
            self.isLoading = false
            
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                if let user = user {
                    self.sessionInfoStore.persistUserInStore(user)
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.postUpdateNotification()
                    })
                    
                }
            })
            
        }
    }
}