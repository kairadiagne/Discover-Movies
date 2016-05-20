//
//  ListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import BRYXBanner
import MBProgressHUD

class ListViewController: BaseViewController {
    
    private struct Constants {
        static let UserInfoKey = "error"
    }

    @IBOutlet weak var tableView: BaseTableView!
    
    private var signInManager = TMDbSignInManager()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check if we are signedin or in public mode or else we need to load the signin view controller
        switch signInManager.signInStatus {
        case .NotAvailable:
           showSignInViewController()
        default: break
        }
    }
    
    // TODO: - Should this be moved to the base view conroller. In other words should this be behavior every view controller in this app should or could have??
    // The same goes for the checking og the signInStatus!!
    // Then this listview conytoller sole responsibility is just providing a tableView for subclasses.
    // Then we can also look up some of the behavior UITableViewController gives us out of the box and recreate this functionality in this view controller.
    
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
        let errorSelector = #selector(TopListViewController.handleError)
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
    
    func handleError(notification: NSNotification) {
        hideProgressHUD()
        
        // Extract the error from the notification
        guard let error = notification.userInfo?[Constants.UserInfoKey] as? NSError else { return }
        detectInternetConnectionError(error)
    }
    
    // MARK: - Navigation 
    
    func showSignInViewController() {
        let signInViewController = SignInViewController()
        presentViewController(signInViewController, animated: true, completion: nil) // Present modally
    }
   
}




