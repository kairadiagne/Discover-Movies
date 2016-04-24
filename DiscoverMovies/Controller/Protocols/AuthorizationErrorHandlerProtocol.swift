//
//  AuthorizationErrorHandlerProtocol.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol AuthorizationErrorHandlerProtocol: class {
    func detectAuthorizationError(error: NSError)
    func handleAuthorizationError()
}

extension AuthorizationErrorHandlerProtocol {
    
    func detectAuthorizationError(error: NSError) {
        if error.domain == NSURLErrorDomain && error.code == NSURLErrorUserAuthenticationRequired {
            handleAuthorizationError()
        }
    }
    
    
}
