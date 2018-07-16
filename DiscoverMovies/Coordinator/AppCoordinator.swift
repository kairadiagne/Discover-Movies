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
    
    // MARK: - Properties

    private let dependencies: AppDependency
    
    private let rootViewController: UINavigationController
    
    private var revealVC: SWRevealViewController! // Remove

    // MARK: - Initialize
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController

        self.dependencies = AppDependency(authenticationManager: AuthenticationManager(),
                                          userDataManager: UserDataManager(),
                                          popularListManager: TopListDataManager(list: .popular),
                                          nowPlayingListManager: TopListDataManager(list: .nowPlaying),
                                          topratedListManager: TopListDataManager(list: .topRated),
                                          upcomingListManager: TopListDataManager(list: .upcoming),
                                          favoritesManager: AccountListDataManager(list: .favorite),
                                          watchListManager: AccountListDataManager(list: .watchlist))
        super.init()
        rootViewController.navigationBar.isHidden = true
    }
    
    // MARK: - Start
    
    func start() {
        showSignInViewController()
//        let navigationController = BaseNavigationController(rootViewController: topListVC)
//        let menuViewController = MenuViewController(sessionManager: sessionManager)
//        revealVC = SWRevealViewController(rearViewController: menuViewController, frontViewController: navigationController)
//
//        menuViewController.delegate = self
//
//        rootViewController.viewControllers = [revealVC]
//
//        if sessionManager.signInStatus == .unkown {
//            showSignInViewController()
//        }
    }
    
    // MARK: - ViewControllers
    
    private func showSignInViewController() {
        let signInViewController = SignInViewController(authenticationManager: dependencies.authenticationManager, userDataManager: dependencies.userDataManager)
        rootViewController.setViewControllers([signInViewController], animated: true)
        
//        rootNavigationController.present(signInViewController, animated: true) {
//            self.revealVC?.setFrontViewPosition(.leftSide, animated: false)
//        }
    }
    
    private func showTopListViewController(animated: Bool) {
//        let topListController = TopListViewController(popularListManager: popularListManager, nowPlayingListManager: nowPlayingListManager, topRatedListManager: topratedListManager, upcomingListManager: upcomingListManager, signedIn: signedIn)
//        let navigationController = BaseNavigationController(rootViewController: topListController)
//        revealVC?.pushFrontViewController(navigationController, animated: animated)
    }
    
    private func showWatchListViewController() {
//        let watchListController = AccountListController(list: .watchlist, manager: watchListManager)
//        let navigationController = BaseNavigationController(rootViewController: watchListController)
//        revealVC?.pushFrontViewController(navigationController, animated: true)
    }
    
    private func showFavoritesViewController() {
//        let favoritesController = AccountListController(list: .favorite, manager: favoritesManager)
//        let navigationController = BaseNavigationController(rootViewController: favoritesController)
//        revealVC?.pushFrontViewController(navigationController, animated: true)
    }
    
    private func showSearchViewController() {
//        let searchViewController = SearchViewController(signedIn: signedIn)
//        let navigationController = BaseNavigationController(rootViewController: searchViewController)
//        revealVC?.pushFrontViewController(navigationController, animated: true)
    }
    
    private func showAboutViewController() {
//        let aboutViewController = AboutViewController()
//        let navigationConttoller = BaseNavigationController(rootViewController: aboutViewController)
//        revealVC?.pushFrontViewController(navigationConttoller, animated: true)
    }
    
    // MARK: Toggle sign in
    
    private func toggleSignIn() {
//        switch sessionManager.signInStatus {
//        case .signedin:
//            signOut()
//        case .publicMode:
//            clearCache()
//            sessionManager.deactivatePublicMode()
//            showSignInViewController()
//        case .unkown:
//            clearCache()
//            showSignInViewController()
//        }
    }
    
    func signOut() {
//        // Clear user data
//        sessionManager.signOut()
//        clearCache()
//        showSignInViewController()
    }
    
    private func clearCache() {
//        popularListManager.clear()
//        nowPlayingListManager.clear()
//        topratedListManager.clear()
//        upcomingListManager.clear()
//        favoritesManager.clear()
//        watchListManager.clear()
    }
    
}

//extension AppCoordinator: SignInViewControllerDelegate {
//
//    func signInViewControllerDidFinish() {
////        showTopListViewController(animated: false)
////        rootViewController.dismiss(animated: true, completion: nil)
//    }
//}

extension AppCoordinator: MenuViewControllerDelegate {
    
//    func menu(viewController: UIViewController, numberOfItemsInSection: Int) -> Int {
//        return 6
//    }
//
//    func menu(viewController: UIViewController, itemForRowAtIndexPath indexPath: IndexPath) -> MenuItem? {
//        return MenuItem(rawValue: indexPath.row)
//    }
//
//    func menu(viewController: UIViewController, didclickItemAtIndexPath indexPath: IndexPath) {
//        // If we are trying to push the same row we change the position of the front view controller
//        if indexPath.row == presentedRow && indexPath.row != 4 { // SignIn/signOut is a toggle
//            revealVC?.setFrontViewPosition(.leftSide, animated: true)
//            return
//        }
//
//        guard let menuItem = MenuItem(rawValue: indexPath.row) else { return }
//
//        switch menuItem {
//        case .topList:
//            showTopListViewController(animated: true)
//        case .watchlist:
//            showWatchListViewController()
//        case .favorites:
//            showFavoritesViewController()
//        case .search:
//            showSearchViewController()
//        case .signin:
//            toggleSignIn()
//        case .about:
//            showAboutViewController()
//        }
//
//        presentedRow = indexPath.row
//    }
}
