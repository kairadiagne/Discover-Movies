//
//  ErrorHandler.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 02-10-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit
import BRYXBanner
import ChameleonFramework

class ErrorHandler {
    
    // MARK: - Properties 
    
    static let shared = ErrorHandler()
    
    private var currentBanner: Banner?
    
    private var currentError: APIError?
    
    // MARK: - Handle Errors 
    
    func handle(error: APIError, authorizationError: Bool = false, hideGenericError: Bool = false) {
        
        // prevent two banners being presented at the same time
        if currentBanner != nil {
            if currentError != error {
                currentBanner?.dismiss()
            } else {
                return
            }
        }
       
        // Create Error Banner
        switch error {
        case .noInternetConnection:
            let title = "noConnectionTitle".localized
            let message = "noConnectionMessage".localized
            currentBanner = Banner(title: title, subtitle: message, backgroundColor: UIColor.flatOrange())
        case .timedOut:
            let title = "noConnectionTitle".localized
            let message = "noConnectionMessage".localized
            currentBanner = Banner(title: title, subtitle: message, backgroundColor: UIColor.flatOrange())
        case .unAuthorized where authorizationError:
            let title = "authorizationErrorTitle".localized
            let message = "authorizationErrorMessage".localized
            currentBanner = Banner(title: title, subtitle: message, backgroundColor: UIColor.flatRed())
        case .generic where hideGenericError != true:
            let title = "genericErrorTitle".localized
            let message = "genericErrorMessage".localized
            currentBanner = Banner(title: title, subtitle: message, backgroundColor: UIColor.flatGray())
        default:
            return
        }
        
        // Cache current error
        currentError = error
        
        // Block that gets exectured after dismissal of banner
        currentBanner?.didDismissBlock = { [weak self] in
            guard let strongSelf = self else { return }
            
            // Sign out user in case of authorization error
            if strongSelf.currentError == .unAuthorized {
//                let appCoordinator = (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator
//                appCoordinator?.signOut()
            }
            
            // Clear cached values
            strongSelf.currentError = nil
            strongSelf.currentBanner = nil
        }
        
        // Present banner at the top of that view
        currentBanner?.dismissesOnTap = true
        currentBanner?.dismissesOnSwipe = true
        currentBanner?.show(duration: 3.0)
    }
}
