//
//  AppCoordinator.swift
//  Discover
//
//  Created by Kaira Diagne on 20-11-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SWRevealViewController

class AppCoordinator: NSObject {
    
    // MARK: - Propperties
    
    private let window: UIWindow
    
    fileprivate let rootNavigationController: UINavigationController
    
    private let sessionManager: TMDbSessionManager
    
    private let topListProxy: TopListDataManageProxy
    
    private let favoritesManager: TMDbAccountListDataManager
    
    private let watchListManager: TMDbAccountListDataManager
    
    fileprivate var presentedRow = 0
    
    fileprivate var revealVC: SWRevealViewController!
    
    fileprivate var signedIn: Bool {
        return sessionManager.signInStatus == .signedin
    }
    
    // MARK: - Initialize
    
    init(window: UIWindow, rootNavController: UINavigationController = BaseNavigationController(), sessionManager: TMDbSessionManager = TMDbSessionManager()) {
        self.window = window
        self.rootNavigationController = rootNavController
        self.window.rootViewController = rootNavController
        self.sessionManager = sessionManager
        self.topListProxy = TopListDataManageProxy()
        self.favoritesManager = TMDbAccountListDataManager(list: .favorite)
        self.watchListManager = TMDbAccountListDataManager(list: .watchlist)
        super.init()
        rootNavigationController.navigationBar.isHidden = true
    }
    
    // MARK: - Start
    
    func start() {
        let topListController = TopListViewController(signedIn: signedIn, toplistProxy: topListProxy)
        let navigationController = BaseNavigationController(rootViewController: topListController)
        let menuViewController = MenuViewController(sessionManager: sessionManager)
        revealVC = SWRevealViewController(rearViewController: menuViewController, frontViewController: navigationController)
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let keys = NSDictionary(contentsOfFile: path), let APIKey = keys["APIKey"] as? String {
            sessionManager.registerAPIKey(APIKey)
        }
        
        menuViewController.delegate = self
        
        rootNavigationController.viewControllers = [revealVC]
        
        if sessionManager.signInStatus == .unkown {
            showSignInViewController()
        }
    }
    
    // MARK: - ViewControllers
    
    fileprivate func showSignInViewController() {
        let signInViewController = SignInViewController(sessionManager: sessionManager)
        signInViewController.delegate = self
        
        rootNavigationController.present(signInViewController, animated: true) {
            self.revealVC?.setFrontViewPosition(.leftSide, animated: false)
        }
    }
    
    fileprivate func showTopListViewController(animated: Bool) {
        let topListController = TopListViewController(signedIn: signedIn, toplistProxy: topListProxy)
        let navigationController = BaseNavigationController(rootViewController: topListController)
        revealVC?.pushFrontViewController(navigationController, animated: animated)
    }
    
    fileprivate func showWatchListViewController() {
        let watchListController = AccountListController(list: .watchlist, manager: watchListManager)
        let navigationController = BaseNavigationController(rootViewController: watchListController)
        revealVC?.pushFrontViewController(navigationController, animated: true)
    }
    
    fileprivate func showFavoritesViewController() {
        let favoritesController = AccountListController(list: .favorite, manager: favoritesManager)
        let navigationController = BaseNavigationController(rootViewController: favoritesController)
        revealVC?.pushFrontViewController(navigationController, animated: true)
    }
    
    fileprivate func showSearchViewController() {
        let searchViewController = SearchViewController(signedIn: signedIn)
        let navigationController = BaseNavigationController(rootViewController: searchViewController)
        revealVC?.pushFrontViewController(navigationController, animated: true)
    }
    
    fileprivate func showAboutViewController() {
        let aboutViewController = AboutViewController()
        let navigationConttoller = BaseNavigationController(rootViewController: aboutViewController)
        revealVC?.pushFrontViewController(navigationConttoller, animated: true)
    }
    
    // MARK: Toggle sign in
    
    fileprivate func toggleSignIn() {
        switch sessionManager.signInStatus {
        case .signedin:
            signOut()
        case .publicMode:
            clearCache()
            sessionManager.deactivatePublicMode()
            showSignInViewController()
        case .unkown:
            clearCache()
            showSignInViewController()
        }
    }
    
    func signOut() {
        // Clear user data
        sessionManager.signOut()
        clearCache()
        showSignInViewController()
    }
    
    fileprivate func clearCache() {
        topListProxy.clearCaches()
        favoritesManager.clear()
        watchListManager.clear()
    }
    
}

extension AppCoordinator: SignInViewControllerDelegate {
    
    func signInViewControllerDidFinish() {
        showTopListViewController(animated: false)
        rootNavigationController.dismiss(animated: true, completion: nil)
    }
}

extension AppCoordinator: MenuViewControllerDelegate {
    
    func menu(viewController: UIViewController, numberOfItemsInSection: Int) -> Int {
        return 6
    }
    
    func menu(viewController: UIViewController, itemForRowAtIndexPath indexPath: IndexPath) -> MenuItem? {
        return MenuItem(rawValue: indexPath.row)
    }
    
    func menu(viewController: UIViewController, didclickItemAtIndexPath indexPath: IndexPath) {
        // If we are trying to push the same row we change the position of the front view controller
        if indexPath.row == presentedRow && indexPath.row != 4 { // SignIn/signOut is a toggle
            revealVC?.setFrontViewPosition(.leftSide, animated: true)
            return
        }
        
        guard let menuItem = MenuItem(rawValue: indexPath.row) else { return }
        
        switch menuItem {
        case .topList:
            showTopListViewController(animated: true)
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
