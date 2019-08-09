//
//  DiscoverTabBarController.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit

final class DiscoverTabBarController: UITabBarController {

    // MARK: - Properties

    private let dependencyContainer: DependencyContainer

    // MARK: - Initialize

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer

        super.init(nibName: nil, bundle: nil)

        let topListViewController = TopListViewControllerFactory.create(with: dependencyContainer)
        topListViewController.tabBarItem = UITabBarItem(title: "topListMenuItemText".localized, image: UIImage(named: "Discover"), selectedImage: nil)
        let topListNavigationController = freshNavigationController(rootViewController: topListViewController)

        let watchListViewController = AcountListViewControllerFactory.createWatchList(with: dependencyContainer)
        watchListViewController.tabBarItem = UITabBarItem(title: "watchListMenuItemText".localized, image: UIImage(named: "Watchlist"), selectedImage: nil)
        let watchListNavigationController = freshNavigationController(rootViewController: watchListViewController)

        let favoritesViewController = AcountListViewControllerFactory.createFavorites(with: dependencyContainer)
        favoritesViewController.tabBarItem = UITabBarItem(title: "favoritesMenuItemText".localized, image: UIImage(named: "Favorite"), selectedImage: nil)
        let favoritesNavigationController = freshNavigationController(rootViewController: favoritesViewController)

        let aboutViewController = AboutViewController()
        aboutViewController.tabBarItem = UITabBarItem(title: "aboutmenuItemText".localized, image: UIImage(named: "About"), selectedImage: nil)
        let aboutNavigationController = freshNavigationController(rootViewController: aboutViewController)

        viewControllers = [topListNavigationController, watchListNavigationController, favoritesNavigationController, aboutNavigationController]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = UIColor.backgroundColor()
        tabBar.tintColor = UIColor.buttonColor()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard dependencyContainer.sessionManager.signInStatus == .unkown else { return }
        let signInViewController = SignInViewControllerFactory.create(with: dependencyContainer)
        signInViewController.delegate = self
        present(signInViewController, animated: true, completion: nil)
    }

    private func freshNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }
}

extension DiscoverTabBarController: SignInViewControllerDelegate {

    func signInViewControllerDidFinish(_ controller: SignInViewController) {
        dismiss(animated: true, completion: nil)
    }
}
