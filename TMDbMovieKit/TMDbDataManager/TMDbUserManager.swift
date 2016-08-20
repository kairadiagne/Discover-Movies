//
//  TMDbUserManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

//public protocol TMDbUserManagerDelegate: class {
//    func userManagerDidLoadUser(user: TMDbUser)
//    func userManagerDidReceiveError(error: TMDbAPIError)
//}
//
//public class TMDbUserManager {
//    
//    // MARK: Properties
//    
//    public weak var delegate: TMDbUserManagerDelegate?
//    
//    public static var shared = TMDbUserManager()
//    
//    private(set) var user: TMDbUser?
//    
//    private let userClient = TMDbUserClient()
//    
//    private let sessionInfoStore = TMDbSessionInfoStore()
//    
//    // MARK: Initialization
//    
//    init() {
//        // Load user from cache
//        self.user = sessionInfoStore.user
//    }
//
//    // MARK: - Fetching
//    
//    public func loadUserInfo() {
//
//        userClient.fetchUserInfo { (user, error) in
//            guard error == nil else {
//                self.handleError(error!)
//                return
//            }
//            
//            if let user = user {
//                self.sessionInfoStore.persistUserInStore(user)
//                self.delegate?.userManagerDidLoadUser(user)
//            }
//        }
//    }
//    
//    // MARK: Error Handling
//    
//    func handleError(error: NSError) {
//        var newError: TMDbAPIError
//        
//        // Determine which kind of error where dealing with
//        if error.code == NSURLErrorNotConnectedToInternet {
//            newError = .NoInternetConnection
//        } else if error.domain == NSURLErrorDomain && error.code == NSURLErrorUserAuthenticationRequired {
//            newError = .NotAuthorized
//        } else {
//            newError = .Generic
//        }
//        
//        delegate?.userManagerDidReceiveError(newError)
//    }
//    
//}