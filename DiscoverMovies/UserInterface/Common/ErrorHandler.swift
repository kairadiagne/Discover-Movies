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
    
    // MARK: - Handle Errors 
    
    func handle(error: APIError, authorizationError: Bool = false) {

        switch error {
        // Show banner for internet connection error
        case .noInternetConnection:
            let title = NSLocalizedString("noConnectionTitle", comment: "Title of no internet connection banner")
            let message = NSLocalizedString("noConnectionMessage", comment: "Message of no internet connection bannner")
            showbanner(with: title, message: message, color: UIColor.flatOrange())
        // Show banner for connection timed out error
        case .timedOut:
            let title = NSLocalizedString("noConnectionTitle", comment: "Title of no internet connection banner")
            let message = NSLocalizedString("noConnectionMessage", comment: "Message of no internet connection bannner")
            showbanner(with: title, message: message, color: UIColor.flatOrange())
        // Show banner for unauthorized error and logout the user
        case .unAuthorized where authorizationError:
            let title = NSLocalizedString("authorizationErrorTitle", comment: "Title of authorization error alert")
            let message = NSLocalizedString("authorizationErrorMessage", comment: "Message of authorization error alert")
            
            showbanner(with: title, message: message, color: UIColor.flatRed(), dismissBlock: {
                let menuViewController = (UIApplication.shared.delegate as? AppDelegate)?.menuViewController
                menuViewController?.signout()
            })
        // Show generic error banner
        case .generic:
            let title = NSLocalizedString("genericErrorTitle", comment: "Title of generic error alert")
            let message = NSLocalizedString("genericErrorMessage", comment: "Message of generic error alert")
            showbanner(with: title, message: message, color: UIColor.flatGray())
            return
        default:
            return
        }
    }
    
    // The banner will be displayed at the top of that view
    // When the banner is not nill it means it is currently being presented on screen
    fileprivate func showbanner(with title: String, message: String, color: UIColor, dismissBlock: (() -> Void)? = nil) {
        // Create and show banner
        let banner = Banner()
        banner.titleLabel.text = title
        banner.detailLabel.text = message
        banner.backgroundColor = color
        banner.dismissesOnSwipe = true
        banner.dismissesOnTap = true
        banner.didTapBlock = dismissBlock
        banner.didDismissBlock = dismissBlock
        
        banner.show(duration: 3.0)
    }
    
}
