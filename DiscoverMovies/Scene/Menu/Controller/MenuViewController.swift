//
//  MenuViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MenuViewController: BaseViewController {
    
    private struct Constants {
        static let MenuCellIdentifier = "MenuCell"
        static let MenuCellNibName = "MenuTableViewCell"
    }
    
    @IBOutlet weak var tableView: MenuTableView!
    
    private let userManager = TMDbUserManager()
    private let signInmanager = TMDbSignInManager()
    private let datasource = MenuDataSource()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: Constants.MenuCellNibName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: Constants.MenuCellIdentifier)
        
        datasource.identifier = Constants.MenuCellIdentifier
        tableView.dataSource = datasource
        tableView.delegate = self
        
        signUpForUpdateNotification(userManager)
        signUpErrorNotification(userManager)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if sessionManager.signInStatus == .Signedin {
           userManager.reloadIfNeeded(true)
        }
    }
    
    private func updateMenuheaderView() {
        if let user = userManager.user, path = user.gravatarURI, url = TMDbImageRouter.PosterMedium(path: path).url {
            tableView.configureProfileHeader(user, url: url)
        } else {
            tableView.configureProfileHeader()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Notifications
    
    override func updateNotification(notification: NSNotification) {
        updateMenuheaderView()
    }
    
    // MARK: - Navigation
    
    func showTopListViewController() {
        let topListViewController = TopListViewController()
        self.navigationController?.pushViewController(topListViewController, animated: true)
    }
    
    func showWatchListViewController() {
        
    }
    
    func showFavoritesViewControlelr() {
        
    }
    
    func signout() {
        signInmanager.signOut()
        showTopListViewController()
    }
    
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let menuItem = datasource.itemForIndex(indexPath.row) else { return }
        
        switch menuItem {
        case .DiscoverMovies:
            showTopListViewController()
        case .Favorites:
            showFavoritesViewControlelr()
        case .WatchList:
            showWatchListViewController()
        case .Signout:
            signout()
        }
    }
    
}
