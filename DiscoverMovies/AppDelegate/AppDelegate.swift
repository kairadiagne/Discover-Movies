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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Theme.applyGlobalTheme() 
        
        TMDbSessionManager.shared.registerAPIKey(APIKey: "b23b0ad7a6c11640e4e232527f2e6d67")
        
        let menuViewController =  MenuViewController.instantiatefromStoryboard() // RearViewController
        let topListViewController = TopListViewController(nibName: String(ListViewController), bundle: nil)
        let frontViewController = UINavigationController(rootViewController: topListViewController)
        revealViewController = SWRevealViewController(rearViewController: menuViewController, frontViewController: frontViewController)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = revealViewController
        window?.makeKeyAndVisible()
 
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// TODO: 
// - Error Messages (No trailer, No Reviews, Not authorized)
// - SearchView SearchViewController, SearchListViewController

// - Localization
// - Pull to refresh (Account list controller)
// - UserInfoStore Multihreading keyed archiver ??
// - Map, Filter, flatMap, reduce revisit and use in models  // Probably map or flatMap for transforming data in an array of dicts
// - filter https://www.weheartswift.com/higher-order-functions-map-filter-reduce-and-more/
// - Change ProfileImageView
// - Color and Design changes



