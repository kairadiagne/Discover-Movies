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
        static let RootViewControllerNibName = "ListViewController"
    }
    
    // MARK: - Storyboard
    
    class func instantiatefromStoryboard() -> MenuViewController {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(Constants.Identifier) as! MenuViewController
    }

    @IBOutlet weak var menuTableview: MenuTableView!
    
    private let userManager = TMDbUserManager()
    private let signInmanager = TMDbSignInManager()
    private let sessionManager = TMDbSessionManager()
        
    private var presentedRow = 1
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if sessionManager.signInStatus == .Signedin {
            userManager.reloadIfNeeded(true)
            menuTableview.updateMenu(true, user: userManager.user)
        } else {
            menuTableview.updateMenu(false, user: nil)
        }
    
    }
   
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Notifications

    
    // MARK: - Navigation
    
    func showTopListViewController() {
        let topListVieWController = TopListViewController(nibName: Constants.RootViewControllerNibName, bundle: nil)
        let navigationController = UINavigationController(rootViewController: topListVieWController)
        revealViewController()?.pushFrontViewController(navigationController, animated: true)
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
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.row {
        case 0:
            return false
        default:
            return true 
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // If we are trying to push the same row or perform an operation that does not imply frontViewController replacement
        // we'll just set the postion and return.
        
        if indexPath.row == presentedRow {
            self.revealViewController()?.setFrontViewPosition(.LeftSide, animated: true)
            return
        }
        
        switch indexPath.row {
        case 0:
            break
        case 1:
            showTopListViewController()
            
        case 2:
            showFavoritesViewControlelr()
            
        case 3:
            showWatchListViewController()
        case 4:
            signout()
        default:
            fatalError()
        }
    }
    
}
