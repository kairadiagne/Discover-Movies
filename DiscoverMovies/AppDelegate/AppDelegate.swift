//
//  AppDelegate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit
import SWRevealViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    var revealViewController: SWRevealViewController!
    
    var menuViewController: MenuViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Theme.applyGlobalTheme() 
        
        // Register APIKey
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let keys = NSDictionary(contentsOfFile: path), let APIKey = keys["APIKey"] as? String {
            TMDbSessionManager.shared.registerAPIKey(APIKey)
        }
        
        let homeViewController = HomeViewController()
        let frontViewController = UINavigationController(rootViewController: homeViewController)
        let rearViewController =  MenuViewController.instantiatefromStoryboard()
        let revealViewController = SWRevealViewController(rearViewController: rearViewController, frontViewController: frontViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = revealViewController
        window?.makeKeyAndVisible()
 
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

// TODO: 
// - Error Messages (No trailer, No Reviews, Not authorized)
// - SearchView SearchViewController, SearchListViewController

// - Localization
// - Pull to refresh (Account list controller)
// - UserInfoStore Multihreading keyed archiver ??
// - Change ProfileImageView
// - Color and Design changes



