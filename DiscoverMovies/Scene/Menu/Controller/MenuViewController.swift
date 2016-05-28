//
//  MenuViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MenuViewController: UITableViewController {
    
    private struct Constants {
        static let Identifier = "MenuViewController"
        static let MenuCellIdentifier = "MenuTableViewCell"
    }
    
    // MARK: - Storyboard
    
    class func instantiatefromStoryboard() -> MenuViewController {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(Constants.Identifier) as! MenuViewController
    }

    private let userManager = TMDbUserManager()
    private let signInmanager = TMDbSignInManager()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        signUpForUpdateNotification(userManager)
//        signUpErrorNotification(userManager)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        if sessionManager.signInStatus == .Signedin {
//           userManager.reloadIfNeeded(true)
//        }
    }
    
//    private func updateMenuheaderView() {
////        if let user = userManager.user, path = user.gravatarURI, url = TMDbImageRouter.PosterMedium(path: path).url {
////            tableView.configureProfileHeader(user, url: url)
////        } else {
////            tableView.configureProfileHeader()
////        }
//    }
//    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Notifications
    
//    override func updateNotification(notification: NSNotification) {
////        updateMenuheaderView()
//    }
    
    // MARK: - Navigation
    
    func showTopListViewController() {
        let topListVieWController = TopListViewController()
        revealViewController()?.pushFrontViewController(topListVieWController, animated: true)

    }
    
    func showWatchListViewController() {
       // Show watchlist view controller
    }
    
    func showFavoritesViewControlelr() {
        // Show favorites view controller
    }
    
    func signout() {
        signInmanager.signOut()
        showTopListViewController()
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            showTopListViewController()
        case 1:
            showFavoritesViewControlelr()
        case 2:
            showWatchListViewController()
        case 3:
            signout()
        default:
            fatalError()
        }
    }
    
}

extension MenuViewController {
    
   
    
}
