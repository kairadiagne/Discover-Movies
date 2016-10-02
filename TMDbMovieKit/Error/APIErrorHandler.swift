//
//  ErrorHandling.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 28-08-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

class APIErrorHandler: ErrorHandling {
    
    func categorize(error: Error) -> APIError {
        if let error = error as? URLError {
            return checkURLError(error: error)
        } else if let error = error as? AFError {
            return checkAFError(error: error)
        } else {
            return .generic
        }
    }
    
    private func checkAFError(error: AFError) -> APIError { 
        if error.responseCode != nil, error.responseCode == 401 {
            return .unAuthorized
        } else {
          return .generic
        }
    }
    
    private func checkURLError(error: URLError) -> APIError {
        if error.code == .notConnectedToInternet {
            return .noInternetConnection
        } else if error.code == .networkConnectionLost {
            return .noInternetConnection
        } else if error.code == .userAuthenticationRequired {
            return .unAuthorized
        } else if error.code == .timedOut {
            return .timedOut
        } else {
            return .generic
        }
    }
    
}
