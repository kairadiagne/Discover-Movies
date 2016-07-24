//
//  TMDbUserManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbUserManager {
    
    // MARK: Properties
    
    public var failureDelegate: DataManagerFailureDelegate?
    
    public static var shared = TMDbUserManager()
    
    public private(set) var user: TMDbUser?
    
    public private(set) var isLoading = false
    
    private let userClient = TMDbUserClient()
    
    private let sessionInfoStore = TMDbSessionInfoStore()
    
    // MARK: Initialization
    
    init() {
        // Load user from cache
        self.user = sessionInfoStore.user
    }

    // MARK: - Fetching
    
    public func loadUserInfo() {
        isLoading = true
        
        userClient.fetchUserInfo { (user, error) in
            guard error == nil else {
                // Check for errors 
                // Call delegate with error 
                return
            }
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                if let user = user {
                    self.sessionInfoStore.persistUserInStore(user)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                    })
                    
                }
            })
            
        }
    }
}