//
//  BaseViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import BRYXBanner
import MBProgressHUD

class BaseViewController: UIViewController, BannerPresentable, ProgressHUDPresentable, InternetErrorHandleable, TMDbDataManagerListenerDelegate {
    
    // MARK: Constants 
    
    private struct Constants {
        static let UserInfoKey = "error"
    }
    
    // MARK: Properties
    
    var banner: Banner?
    
    var progressHUD: MBProgressHUD?
    
    var sessionManager = TMDbSessionManager()
    
    var shouldShowSignInViewController: Bool {
        switch sessionManager.signInStatus {
        case .NotAvailable:
            return true
        default:
            return false
        }
    }
    
    // MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressHUD()
    }
    
    // MARK: Notifications
    
    func dataManagerDataDidChangeNotification(notification: NSNotification) {
        hideProgressHUD()
    }
        
    func dataManagerDidReceiveErrorNotification(error: NSError?) {
        hideProgressHUD()
    }
        
    func dataManagerDataDidUpdateNotification(notification: NSNotification) {
        hideProgressHUD()
        
        if let error = notification.userInfo?[Constants.UserInfoKey] as? NSError {
            detectInternetConnectionError(error)
        }
    }
    
    // MARK: Navigation
    
    func showSignInViewController() {
        let signInViewController = SignInViewController()
        presentViewController(signInViewController, animated: true, completion: nil)
    }

}


