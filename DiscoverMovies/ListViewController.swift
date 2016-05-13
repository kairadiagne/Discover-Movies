//
//  ListViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import BRYXBanner
import MBProgressHUD

class ListViewController: BaseViewController {
    
    private struct Constants {
        static let UserInfoKey = "error"
    }

    @IBOutlet weak var tableView: ListTableView!
    
    // MARK: - Handle Incoming Notifications
    
    // These methods are for handeling incoming notifications from the data manager
    // They automatically hide the progress hud if there is one and check for basic error. 
    
    func updateNotification(notification: NSNotification) {
        hideProgressHUD()
    }
    
    func handleError(notification: NSNotification) {
        hideProgressHUD()
        
        // Extract the error from the notification
        guard let error = notification.userInfo?[Constants.UserInfoKey] as? NSError else { return }
        detectInternetConnectionError(error)
    }
   
}



