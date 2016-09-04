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

    // MARK: Storyboard
    
    class func instantiatefromStoryboard() -> MenuViewController {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(String(MenuViewController)) as! MenuViewController
    }
    
    // MARK: Properties

    @IBOutlet weak var menuTableview: MenuTableView!
    
    private let userService = TMDbUserService()

    private var signedIn: Bool {
        return (TMDbSessionManager.shared.signInStatus == .Signedin) ?? false
    }
    
    private var presentedRow = 1
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userService.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if signedIn && (TMDbSessionManager.shared.user == nil) {
            menuTableview.updateMenu(signedIn)
            userService.getUserInfo() // Get latest
        } else if signedIn && (TMDbSessionManager.shared.user != nil) {
            menuTableview.updateMenu(signedIn, user: TMDbSessionManager.shared.user!)
            userService.getUserInfo() // Get latest
        } else {
             menuTableview.updateMenu(signedIn)
        }
      
    }
   
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: Navigation
    
    func showTopListViewController() {
        let topListVieWController = TopListViewController(nibName: String(ListViewController), bundle: nil)
        let navigationController = UINavigationController(rootViewController: topListVieWController)
        revealViewController()?.pushFrontViewController(navigationController, animated: true)
    }
    
    func showWatchListViewController() {
        let watchListController = AccountListController(list: .Favorite)
        let navigationController = UINavigationController(rootViewController: watchListController)
        revealViewController()?.pushFrontViewController(navigationController, animated: true)
    }
    
    func showFavoritesViewController() {
        let favoritesController = AccountListController(list: .Watchlist)
        let navigationController = UINavigationController(rootViewController: favoritesController)
        revealViewController()?.pushFrontViewController(navigationController, animated: true)
    }
    
    // MARK: Sign in / Sign out
    
    func signIn() {
        showTopListViewController()
    }
    
    func signOut() {
        TMDbSessionManager.shared.signOut()
        showTopListViewController()
    }
    
    private func toggleSignIn() {
        if signedIn {
            signOut()
        } else {
            TMDbSessionManager.shared.deactivatePublicMode()
        }
        
        showTopListViewController()
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.row {
        case 0:
            return false
        default:
            return true 
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   
        // If we are trying to push the same row we change the position of the front view controller
        if indexPath.row == presentedRow && indexPath.row != 4 {
            self.revealViewController()?.setFrontViewPosition(.LeftSide, animated: true)
            return
        }
        
        switch indexPath.row {
        case 1:
            showTopListViewController()
        case 2:
            showFavoritesViewController()
        case 3:
            showWatchListViewController()
        case 4:
            toggleSignIn()
        default:
            break
        }
        
        presentedRow = indexPath.row
    }
    
}

// MARK: - TMDbUserServiceDelegate

extension MenuViewController: TMDbUserServiceDelegate {
    
    func user(service: TMDbUserService, didLoadUserInfo user: User) {
        menuTableview.updateMenu(signedIn, user: user)
    }
    
    func user(service: TMDbUserService, didFailWithError error: TMDbAPIError) {
        // What to do with this error
    }
}

