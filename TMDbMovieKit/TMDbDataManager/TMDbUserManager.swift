//
//  TMDbUserManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
// Use principles of launch mode manager 
public class TMDbUserManager: TMDbBaseDataManager {
    
    // MARK: Properties
    
    public var user: TMDbUser? {
        return sessionInfoStore.user
    }
    
    private let userClient = TMDbUserClient()
    
    private let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: - Fetching
    
    public func loadUserInfo() {
        state = .Loading
        
        userClient.fetchUserInfo { (user, error) in
            guard error == nil else {
                self.handleError(error!)
                return
            }
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                if let user = user {
                    self.sessionInfoStore.persistUserInStore(user)
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.state = .DataDidLoad
                    })
                    
                }
            })
            
        }
    }
}