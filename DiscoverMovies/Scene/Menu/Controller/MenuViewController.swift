//
//  MenuViewController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

class MenuViewController: UIViewController {
    
    private struct Constants {
        static let MenuCellIdentifier = "MenuCell"
        static let MenuCellNibName = "MenuTableViewCell"
    }
    
    @IBOutlet weak var tableView: MenuTableView!
    
    private let signInManager = TMDbSignInManager()
    private let userManager = TMDbUserManager()
    
    private var signInStatus: TMDBSigInStatus {
        return signInManager.signInStatus
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up table view
        tableView.dataSource = self
        let nib = UINib(nibName: Constants.MenuCellNibName, bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: Constants.MenuCellIdentifier)
        
        // Sign up for notifcations from user manager
        let updateSelector = #selector(MenuViewController.update(_:))
        let errorSelector = #selector(MenuViewController.handleError(_:))
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: updateSelector, name: TMDbManagerDataDidUpdateNotification, object: userManager)
        notificationCenter.addObserver(self, selector: errorSelector, name: TMDbManagerDidReceiveErrorNotification, object: userManager)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if signInStatus == .Signedin {
            userManager.reloadIfNeeded(true)
        } else {
            tableView.configureForUser(nil, url: nil)
        }
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Notifications
    
    func update(notification: NSNotification) {
        guard let user = userManager.user, path = user.gravatarURI else { return }
        let url = TMDbImageRouter.ProfileMedium(path: path).url
        tableView.configureForUser(user, url: url)
    }
    
    func handleError(notification: NSNotification) {
        
    }
    
    // MARK: - Navigation
    
    func signout() {
        
    }
        
    func showFavoritesViewControlelr() {
        
    }
        
    func showWatchListViewController() {
        
    }
        
    func showDiscoverViewController() {
        
    }
    
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.MenuCellIdentifier) as! MenuTableViewCell
        switch indexPath.row {
        case 0:
            cell.configureWithItem("Discover movies", imageName: "Discover")
        case 1:
            cell.configureWithItem("Movies I want to watch", imageName: "Watchlist")
        case 2:
            cell.configureWithItem("My favorite movies", imageName: "Favorite")
        case 3:
            cell.configureWithItem("Signout", imageName: "Logout")
        default:
            fatalError()
        }
        return cell
    }
    
}





