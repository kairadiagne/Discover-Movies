//
//  AppDelegate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    private(set) var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        appCoordinator = AppCoordinator()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator
        window?.makeKeyAndVisible()
        
        Theme.apply()

        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        guard let rootViewController = window?.rootViewController else { return .portrait }
        let topController = topViewController(withRootViewController: rootViewController)
        return topController is VideoViewController ? .allButUpsideDown : .portrait
    }
    
    // Gets the top view controller from the window
    private func topViewController(withRootViewController rootViewController: UIViewController) -> UIViewController {
        if let tabBarController = rootViewController as? UITabBarController, let selectedController = tabBarController.selectedViewController {
            return topViewController(withRootViewController: selectedController)
        } else if let navigationController = rootViewController as? UINavigationController, let visibleController = navigationController.visibleViewController {
            return topViewController(withRootViewController: visibleController)
        } else if let presentedViewController = rootViewController.presentedViewController {
            return topViewController(withRootViewController: presentedViewController)
        } else {
            return rootViewController
        }
    }

}
