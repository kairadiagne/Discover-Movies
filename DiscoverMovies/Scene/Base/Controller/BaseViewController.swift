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

class BaseViewController: UIViewController, BannerPresentable, ProgressHUDPresentable, InternetErrorHandleable {

    private struct Constants {
        static let HUDSize = CGSize(width: 40, height: 40)
        static let UserInfoKey = "error"
    }
    
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
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressHUD = MBProgressHUD.hudWithSize(Constants.HUDSize, forFrame: view.bounds)
        view.addSubview(progressHUD!)
    }
    
    // MARK: - Navigation 
    
    func showSignInViewController() {
        let signInViewController = SignInViewController()
        presentViewController(signInViewController, animated: true, completion: nil)
    }
    
    // MARK: - Sign up for TMDbDataManagerNotifications
    
    func signUpForUpdateNotification(object: AnyObject) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let updateSelector = #selector(TopListViewController.updateNotification(_:))
        notificationCenter.addObserver(self, selector: updateSelector, name: TMDbManagerDataDidUpdateNotification, object: object)
    }
    
    func signUpForChangeNotification(object: AnyObject) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let changeSelector = #selector(TopListViewController.changeNotification(_:))
        notificationCenter.addObserver(self, selector: changeSelector, name: TMDManagerDataDidChangeNotification, object: object)
    }
    
    func signUpErrorNotification(object: AnyObject) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let errorSelector = #selector(TopListViewController.handleErrorNotification(_:))
        notificationCenter.addObserver(self, selector: errorSelector, name: TMDbManagerDidReceiveErrorNotification, object: object)
    }
    
    func stopObservingNotifications() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Handle Incoming Notifications
    
    func updateNotification(notification: NSNotification) {
        hideProgressHUD()
    }
    
    func changeNotification(notification: NSNotification) {
        hideProgressHUD()
    }
    
    func handleErrorNotification(notification: NSNotification) {
        hideProgressHUD()
        
        guard let error = notification.userInfo?[Constants.UserInfoKey] as? NSError else { return }
        detectInternetConnectionError(error)
    }

}
