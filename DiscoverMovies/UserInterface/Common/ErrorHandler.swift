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
    
    fileprivate var banner: Banner?
    
    // MARK: - Init
    
    // MARK: - Handle Errors 
    
    func handle(error: APIError, isAuthorized: Bool = false) {
        
        // Conditional if signed in or not 

        switch error {
        case .noInternetConnection:
            let title = NSLocalizedString("noConnectionTitle", comment: "Title of no internet connection banner")
            let message = NSLocalizedString("noConnectionMessage", comment: "Message of no internet connection bannner")
            showbanner(with: title, message: message, color: UIColor.flatOrange())
        case .timedOut:
            let title = NSLocalizedString("noConnectionTitle", comment: "Title of no internet connection banner")
            let message = NSLocalizedString("noConnectionMessage", comment: "Message of no internet connection bannner")
            showbanner(with: title, message: message, color: UIColor.flatOrange()) // Timed out error
        case .unAuthorized:
            let title = NSLocalizedString("authorizationErrorTitle", comment: "Title of authorization error alert")
            let message = NSLocalizedString("authorizationErrorMessage", comment: "Message of authorization error alert")
            showbanner(with: title, message: message, color: UIColor.flatRed())
        case .generic:
            let title = NSLocalizedString("genericErrorTitle", comment: "Title of generic error alert")
            let message = NSLocalizedString("genericErrorMessage", comment: "Message of generic error alert")
            showbanner(with: title, message: message, color: UIColor.flatGray())
            return
        }
        
        // Authorization where Signedin
        // Authorization where Unknown
        // Authorization where publicMode
    }
    
    // The banner will be displayed at the top of that view
    // When the banner is not nill it means it is currently being presented on screen
    fileprivate func showbanner(with title: String, message: String, color: UIColor) {
        // Hide previous banner if there is one
        banner?.dismiss()
        
        // Create and show new banner
        banner = Banner()
        banner?.titleLabel.text = title
        banner?.detailLabel.text = message
        banner?.backgroundColor = color
        banner?.dismissesOnSwipe = true
        
        banner?.show()
    }
    
}







//
//            if let menuViewController = (UIApplication.shared.delegate as? AppDelegate)?.menuViewController {
//                menuViewController.signOut()
//            }
//        }
//

//
//
//
//    fileprivate func presentAlertWithTitle(_ title: String, message: String, completionhandler: (() -> Void)?) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//
//        let dismiss = UIAlertAction(title: "dismiss", style: .default) { action  in
//            completionhandler?()
//        }
//
//        alertController.addAction(dismiss)
//
//        present(alertController, animated: true, completion: nil)
//    }
