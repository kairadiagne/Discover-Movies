//
//  ErrorHandling.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 28-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Alamofire

public enum APIError: Error {
    case generic
    case noInternetConnection
    case unAuthorized
    case timedOut
}

final class APIErrorHandler {
    
    static func categorize(error: Error) -> APIError {
        if let error = error as? URLError {
            if error.code  == .notConnectedToInternet {
                return .noInternetConnection
            } else if error.code == .networkConnectionLost {
                return .noInternetConnection
            } else if error.code == .timedOut {
                return .timedOut
            } else if error.code == .userAuthenticationRequired {
                return .unAuthorized
            } else {
                return .generic
            }
        } else if let error = error as? AFError {
            if error.responseCode == 401 {
                return .unAuthorized
            }
        }
        return .generic
    }
}
