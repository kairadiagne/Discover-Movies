//
//  ErrorHandling.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 28-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol ErrorHandling {
    func categorize(error: Error) -> APIError
}

class APIErrorHandler: ErrorHandling {
    
    func categorize(error: Error) -> APIError {
        guard let error = error as? URLError else { return .generic }
        
        if error.code == .notConnectedToInternet {
            return .noInternetConnection
        } else if error.code == .networkConnectionLost {
            return .noInternetConnection
        } else if error.code == .userAuthenticationRequired {
            return .notAuthorized
        } else if error.code == .timedOut {
            return .timedOut
        } else {
            return .generic
        }
    }
    
}
