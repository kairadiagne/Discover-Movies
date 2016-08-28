//
//  ErrorHandling.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 28-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol ErrorHandling {
    func categorizeError(error: NSError) -> TMDbAPIError
}

extension ErrorHandling {
    
    public func categorizeError(error: NSError) -> TMDbAPIError {
        if error.code == NSURLErrorNotConnectedToInternet {
            return .NoInternetConnection
        } else if error.code == NSURLErrorUserAuthenticationRequired {
            return .NotAuthorized
        } else {
            return .Generic
        }
    }
    
}
