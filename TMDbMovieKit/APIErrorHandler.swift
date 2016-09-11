//
//  ErrorHandling.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 28-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol ErrorHandling {
    func categorize(error: NSError) -> APIError
}

class APIErrorHandler: ErrorHandling {
    
    func categorize(error: NSError) -> APIError {
        guard let error = error as? URLError else { return .generic }
        
        switch error {
        case NSURLError.NoInternetConnection:
            return .noInternetConnection
        case .networkConnectionLost:
            return .noInternetConnection
        case .userAuthenticationRequired:
            return .notAuthorized
        case .timedOut:
            return .timedOut
        default:
            return .generic
        }
    }
    
}
