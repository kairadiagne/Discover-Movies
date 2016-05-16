//
//  AuthorizationErrorHandleable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

// MARK: - Protocol AuthorizationErrorHandleable

protocol AuthorizationErrorHandleable {
    func detectAuthorizationError(error: NSError)
    func handleAuthorizationError()
}

// MARK: - Default Implementation AuthorizationErrorHandleable

extension AuthorizationErrorHandleable where Self: UIViewController {
    
    func detectAuthorizationError(error: NSError) {
        if error.domain == NSURLErrorDomain && error.code == NSURLErrorUserAuthenticationRequired {
            // Tell the user (UIAlert) that he or she is not signd in and needs to authorize
            // TODO: - Start Using NSLocalized string
            let title = "Authorization Error"
            let message = "This feature requires you to sign in with a TMDb account"
            showAlertWithTitle(title, message: message, completionHandler: { (_) in
                self.handleAuthorizationError()
            })
            
        }
    }
    
}

