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

    @IBOutlet weak var tableView: ListTableView!
    
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
   
}




