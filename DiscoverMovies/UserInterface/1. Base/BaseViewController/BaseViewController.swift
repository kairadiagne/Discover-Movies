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

class BaseViewController: UIViewController, BannerPresentable, ProgressHUDPresentable {
    
    // MARK: Types
    
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
    
    var signedIn: Bool {
        return sessionManager.signInStatus == .Signedin ? true: false 
    }
    
    // MARK: View Controller LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressHUD = MBProgressHUD.hudWithSize(CGSize(width: 40, height: 40), forFrame: view.bounds)
        progressHUD?.userInteractionEnabled = false
        view.addSubview(progressHUD!)
    }
    
    // MARK: Notifications
    
    func dataDidChangeNotification(notification: NSNotification) {
        hideProgressHUD()
    }
    
    //MARK: Communicate State 
    
    func presentBannerOnInternetError() {
        let title = "No, Internet Connection" // NSLocalized String
        let message = "Couldn't load any information, please check your connection and try again later" // NSLocalized String
        showBanner(title, message: message, color: UIColor.flatOrangeColor())
    }
    
    func presentAlertOnAuthorizationError() {
        let title = "Authorization Error" // NSLocalized String
        let message = "This feature requires you to sign in with a TMDb account" // NSLocalized String
    }
    
    func presentAlertOnUnknownError() {
        let title = "Unknown Error" // NSLocalized String
        let message = "An unknown error occurred" // NSLocalized String
    }
    
    func handleErrorState(error: TMDbError?, authorizationRequired: Bool = false) {
        guard let error = error else { return }
        
        switch error {
        case .Network:
            presentBannerOnInternetError()
        case .Authorization:
            if authorizationRequired {
                presentAlertOnAuthorizationError()
            }
        case .Unknown:
            presentAlertOnUnknownError()
        }
    }

    // MARK: Navigation
    
    func showSignInViewController() {
        let signInViewController = SignInViewController()
        presentViewController(signInViewController, animated: true, completion: nil)
    }

}

