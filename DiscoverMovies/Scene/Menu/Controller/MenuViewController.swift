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
        tableView.dataSource = self
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let updateSelector = #selector(MenuViewController.update(_:))
        notificationCenter.addObserver(self, selector: updateSelector, name: TMDbManagerDataDidUpdateNotification, object: userManager)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if signInManager.signInStatus == .Signedin {
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








