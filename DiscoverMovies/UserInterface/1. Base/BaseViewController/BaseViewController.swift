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
    
    var shouldShowSignInViewController: Bool {
        return TMDbSessionManager.shared.signInStatus == .NotAvailable ? true : false
    }
    
    private var signedIn: Bool {
        return TMDbSessionManager.shared.signInStatus == .Signedin ? true: false
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressHUD = MBProgressHUD.hudWithSize(CGSize(width: 40, height: 40), forFrame: view.bounds)
        progressHUD?.userInteractionEnabled = false
        view.addSubview(progressHUD!)
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
    
    // MARK: Error Handeling
    
    func listDataManager(manager: AnyObject, didFailWithError error: TMDbAPIError) {
        handleError(error)
    }
    
    func handleError(error: TMDbAPIError) {
        switch error {
        case .Generic:
            presentAlertGenericError()
        case .NoInternetConnection:
            presentBannerOnInternetError()
        case .NotAuthorized where TMDbSessionManager.shared.signInStatus == .Signedin:
            presentAlertOnAuthorizationError()
        case .NotAuthorized where TMDbSessionManager.shared.signInStatus == .NotAvailable:
            presentAlertOnAuthorizationError()
        case .NotAuthorized where TMDbSessionManager.shared.signInStatus == .PublicMode:
            return
        default:
            return
        }
    }
    
    func presentBannerOnInternetError() {
        let title = NSLocalizedString("noConnectionTitle", comment: "Title of no internet connection banner")
        let message = NSLocalizedString("noConnectionMessage", comment: "Message of no internet connection bannner")
        showBanner(title, message: message, color: UIColor.flatOrangeColor())
    }
    
    func presentAlertOnAuthorizationError() {
        let title = NSLocalizedString("authorizationErrorTitle", comment: "Title of authorization error alert")
        let message = NSLocalizedString("authorizationErrorMessage", comment: "Message of authorization error alert")
        
        let completionHandler = {
            TMDbSessionManager.shared.signOut()
            
            if let menuViewController = (UIApplication.sharedApplication().delegate as? AppDelegate)?.menuViewController {
                menuViewController.signOut()
            }
        }
    
        presentAlertWithTitle(title, message: message, completionhandler: completionHandler)
    }
    
    func presentAlertGenericError() {
        let title = NSLocalizedString("genericErrorTitle", comment: "Title of generic error alert")
        let message = NSLocalizedString("genericErrorMessage", comment: "Message of generic error alert")
        presentAlertWithTitle(title, message: message, completionhandler: nil)
    }
    
    private func presentAlertWithTitle(title: String, message: String, completionhandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let dismiss = UIAlertAction(title: "dismiss", style: .Default) { action  in
            completionhandler?()
        }
        
        alertController.addAction(dismiss)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: Navigation
    
    func showSignInViewController() {
        let signInViewController = SignInViewController()
        presentViewController(signInViewController, animated: true, completion: nil)
    }

}
