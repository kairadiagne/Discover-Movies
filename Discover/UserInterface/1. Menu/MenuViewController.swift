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
    
    // MARK: - Types
    
    enum MenuItem: Int {
        case topList
        case watchlist
        case favorites
        case search
        case signin
        case about
        
        private var signedIn: Bool {
            return TMDbSessionManager.shared.signInStatus == .signedin
        }
        
        var text: String {
            switch self {
            case .topList:
                return NSLocalizedString("topListMenuItemText", comment: "")
            case .watchlist:
                return NSLocalizedString("watchListMenuItemText", comment: "")
            case .favorites:
                return NSLocalizedString("favoritesMenuItemText", comment: "")
            case .search:
                return NSLocalizedString("searchMenuItemText", comment: "")
            case .signin:
                return signedIn ? NSLocalizedString("signOutMenuItemText", comment: "") : NSLocalizedString("signInMenuItemText", comment: "")
            case .about:
                return NSLocalizedString("aboutmenuItemText", comment: "")
            }
            
        }
        
        var icon: UIImage? {
            switch self {
            case .topList:
                return UIImage(named: "Discover")
            case .watchlist:
                return UIImage(named: "Watchlist")
            case .favorites:
                return UIImage(named: "Favorite")
            case .search:
                return UIImage(named: "Search")
            case .signin:
                return UIImage(named: "Logout")
            case .about:
                return UIImage(named: "About")
            }
        }
    }
    
    // MARK: - Properties

    @IBOutlet var menuView: MenuView!
    
    fileprivate let userService = TMDbUserService()

    fileprivate var signedIn: Bool {
        return TMDbSessionManager.shared.signInStatus == .signedin
    }
    
    fileprivate var user: User? {
        return TMDbSessionManager.shared.user
    }
    
    fileprivate var presentedRow = 0
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuCellNib = UINib(nibName: MenuTableViewCell.nibName(), bundle: nil)
        menuView.tableView.register(menuCellNib, forCellReuseIdentifier: MenuTableViewCell.defaultIdentifier())
        
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        
        menuView.tableView.bounces = false
        
        userService.delegate = self
        
        menuView.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if signedIn {
            userService.getUserInfo()
        }
        
        menuView.configure(withUser: user)
        menuView.tableView.reloadData()
    }
   
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: Navigation
    
    func showTopListViewController() {
        let topListViewController = TopListViewController()
        let navigationController = UINavigationController(rootViewController: topListViewController)
        revealViewController()?.pushFrontViewController(navigationController, animated: true)
    }
    
    func showWatchListViewController() {
        let watchListController = AccountListController(list: .watchlist)
        let navigationController = UINavigationController(rootViewController: watchListController)
        revealViewController()?.pushFrontViewController(navigationController, animated: true)
    }
    
    func showFavoritesViewController() {
        let favoritesController = AccountListController(list: .favorite)
        let navigationController = UINavigationController(rootViewController: favoritesController)
        revealViewController()?.pushFrontViewController(navigationController, animated: true)
    }
    
    func showSearchViewController() {
        let searchViewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        revealViewController()?.pushFrontViewController(navigationController, animated: true)
    }
    
    func showAboutViewController() {
        let aboutViewController = AboutViewController()
        let navigationConttoller = UINavigationController(rootViewController: aboutViewController)
        revealViewController()?.pushFrontViewController(navigationConttoller, animated: true)
    }
    
    // MARK: - Toggle sign in
    
    fileprivate func toggleSignIn() {
        if signedIn {
            signout()
            return
        } else {
            TMDbSessionManager.shared.deactivatePublicMode()
            showTopListViewController()
        }
    }
    
    func signout() {
        TMDbSessionManager.shared.signOut()
        showTopListViewController()
    }
    
}

// MARK: - UITableViewDataSource 

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.defaultIdentifier()) as? MenuTableViewCell else { return MenuTableViewCell() }
        guard let menuItem = MenuItem(rawValue: indexPath.row) else { return cell }
        
        switch menuItem {
       
        case .watchlist, .favorites:
            cell.configure(title: menuItem.text, image: menuItem.icon, signedIn: signedIn)
            return cell
        default:
            cell.configure(title: menuItem.text, image: menuItem.icon)
            return cell
        }
    }

}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If we are trying to push the same row we change the position of the front view controller
        if indexPath.row == presentedRow && indexPath.row != 4 { // Except sign out
            revealViewController()?.setFrontViewPosition(.leftSide, animated: true)
            return
        }
        
        guard let menuItem = MenuItem(rawValue: indexPath.row) else { return }
        
        switch menuItem {
        case .topList:
            showTopListViewController()
        case .watchlist:
            showWatchListViewController()
        case .favorites:
            showFavoritesViewController()
        case .search:
            showSearchViewController()
        case .signin:
            toggleSignIn()
        case .about:
            showAboutViewController()
        }
        
        presentedRow = indexPath.row
    }
    
}

// MARK: - TMDbUserServiceDelegate

extension MenuViewController: TMDbUserServiceDelegate {
    
    func user(service: TMDbUserService, didLoadUserInfo user: User) {
        menuView.configure(withUser: user)
        menuView.tableView.reloadData()
    }
    
    func user(service: TMDbUserService, didFailWithError error: APIError) {
        ErrorHandler.shared.handle(error: error)
    }
    
}
