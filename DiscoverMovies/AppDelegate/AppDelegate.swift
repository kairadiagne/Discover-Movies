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
    
    private struct Constants {
        static let RootViewControllerNibName = "DiscoverViewController"
    }

    var window: UIWindow?
    var navigationController = UINavigationController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Apply the theme
        Theme.applyGlobalTheme() 
        
        // Register API key for use with TMDbMovieKit
        TMDbSessionManager().registerAPIKey(APIKey: "b23b0ad7a6c11640e4e232527f2e6d67")
        
        // Set up SWRevealController 
        
        // Initialize navigation controller with root viewcontroller and set it as the windows root view controller // Later this becomes a SWRevealController
        
        let topListViewController = TopListViewController(nibName: Constants.RootViewControllerNibName, bundle: nil)
        let navigationController = UINavigationController(rootViewController: topListViewController)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        // Make sure there is no sessionID stored in the keychain from previous installs 
 
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

