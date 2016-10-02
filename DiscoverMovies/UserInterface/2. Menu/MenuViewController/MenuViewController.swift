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
        case signin
        // case search
        
        private var signedIn: Bool {
            return TMDbSessionManager.shared.signInStatus == .signedin
        }
        
        var text: String {
            switch self {
            case .topList:
                return "Discover top movies"
            case .watchlist:
                return "Movies I want to watch"
            case .favorites:
                return "My favorite movies"
            case .signin:
                return signedIn ? "Sign out" : "Sign in"
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
            case .signin:
                return UIImage(named: "Logout")
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
    
    func showHomeViewController() {
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
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
    
    // MARK: - Toggle sign in
    
    fileprivate func toggleSignIn() {
        if signedIn {
            TMDbSessionManager.shared.signOut()
        } else {
            TMDbSessionManager.shared.deactivatePublicMode()
        }
        
        showHomeViewController()
    }
    
}

// MARK: - UITableViewDataSource 

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.defaultIdentifier()) as? MenuTableViewCell else { return MenuTableViewCell() }
        guard let menuItem = MenuItem(rawValue: indexPath.row) else { return cell }
        
        switch menuItem {
        case .topList:
            cell.configure(title: menuItem.text, image: menuItem.icon)
            return cell
        case .watchlist:
            cell.configure(title: menuItem.text, image: menuItem.icon, signedIn: signedIn)
            return cell
        case .favorites:
            cell.configure(title: menuItem.text, image: menuItem.icon, signedIn: signedIn)
            return cell
        case .signin:
            cell.configure(title: menuItem.text, image: menuItem.icon)
            return cell
        }
    }

}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If we are trying to push the same row we change the position of the front view controller
        if indexPath.row == presentedRow && indexPath.row != 4 {
            self.revealViewController()?.setFrontViewPosition(.leftSide, animated: true)
            return
        }
        
        guard let menuItem = MenuItem(rawValue: indexPath.row) else { return }
        
        switch menuItem {
        case .topList:
            showHomeViewController()
        case .watchlist:
            showWatchListViewController()
        case .favorites:
            showFavoritesViewController()
        case .signin:
            toggleSignIn()
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
        // Handle error 
    }
    
}
