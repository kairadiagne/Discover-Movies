//
//  ErrorHandling.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 28-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol ErrorHandling {
    func categorize(error error: NSError) -> TMDbAPIError
}

class APIErrorHandler: ErrorHandling {
    
    func categorize(error error: NSError) -> TMDbAPIError {
        guard let error = error as? NSURLError else { return .Generic }
        
        switch error {
        case .NotConnectedToInternet:
            return .NoInternetConnection
        case .NetworkConnectionLost:
            return .NoInternetConnection
        case .UserAuthenticationRequired:
            return .NotAuthorized
        case .TimedOut:
            return .TimedOut
        default:
            return .Generic
        }
    }
    
}
