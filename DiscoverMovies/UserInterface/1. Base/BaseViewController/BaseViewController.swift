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

class BaseViewController: UIViewController, BannerPresentable, ProgressHUDPresentable, DataManagerFailureDelegate {
    
    // MARK: Types
    
    private struct Constants {
        static let UserInfoKey = "error"
    }
    
    // MARK: Properties
    
    var banner: Banner?
    
    var progressHUD: MBProgressHUD?
    
    var sessionManager = TMDbSessionManager()
    
    var authorizationRequired: Bool = false

    var shouldShowSignInViewController: Bool {
        switch sessionManager.signInStatus {
        case .NotAvailable:
            return true
        default:
            return false
        }
    }
    
    var signedIn: Bool {
        return sessionManager.signInStatus == .Signedin ? true: false 
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressHUD = MBProgressHUD.hudWithSize(CGSize(width: 40, height: 40), forFrame: view.bounds)
        progressHUD?.userInteractionEnabled = false
        view.addSubview(progressHUD!)
    
    }
    
    // MARK: Error Handling
    
    func listDataManager(manager: AnyObject, didFailWithError error: TMDbAPIError) {
       handleError(error)
    }
    
    func handleError(error: TMDbAPIError) {
        switch error {
        case .Generic:
            presentAlertGenericError()
        case .NoInternetConnection:
            presentBannerOnInternetError()
        case .NotAuthorized:
            if authorizationRequired {
                presentAlertOnAuthorizationError()
            }
        }
    }

    // MARK: Notifications
    
    func dataDidStartLoadingNotification(notification: NSNotification) {
        showProgressHUD()
    }
    
    func dataDidLoadTopNotification(notification: NSNotification) {
        hideProgressHUD()
    }
    
    func dataDidUpdateNotification(notification: NSNotification) {
        hideProgressHUD()
    }
    
    // MARK: Communicate State 
    
    func presentBannerOnInternetError() {
        let title = NSLocalizedString("noConnectionTitle", comment: "Title of no internet connection banner")
        let message = NSLocalizedString("noConnectionMessage", comment: "Message of no internet connection bannner")
        showBanner(title, message: message, color: UIColor.flatOrangeColor())
    }
    
    func presentAlertOnAuthorizationError() {
        let title = NSLocalizedString("authorizationErrorTitle", comment: "Title of authorization error alert")
        let message = NSLocalizedString("authorizationErrorMessage", comment: "Message of authorization error alert")
    }
    
    func presentAlertGenericError() {
        let title = NSLocalizedString("genericErrorTitle", comment: "Title of generic error alert")
        let message = NSLocalizedString("genericErrorMessage", comment: "Message of generic error alert")
    }
    
    // MARK: Navigation
    
    func showSignInViewController() {
        let signInViewController = SignInViewController()
        presentViewController(signInViewController, animated: true, completion: nil)
    }

}
