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
        
        // Set up revealcontroller
        let menuViewController =  MenuViewController.instantiatefromStoryboard() // RearViewController
        let topListViewController = TopListViewController(nibName: String(describing: ListViewController), bundle: nil)
        let frontViewController = UINavigationController(rootViewController: topListViewController)
        revealViewController = SWRevealViewController(rearViewController: menuViewController, frontViewController: frontViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = revealViewController
        window?.makeKeyAndVisible()
 
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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



