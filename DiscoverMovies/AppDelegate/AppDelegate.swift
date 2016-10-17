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
        menuViewController =  MenuViewController() // Rear view controlelr
        revealViewController = SWRevealViewController(rearViewController: menuViewController, frontViewController: frontViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = revealViewController
        window?.makeKeyAndVisible()
 
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if let navigationController = revealViewController?.frontViewController as? UINavigationController, let _ = navigationController.visibleViewController as? VideoViewController {
            return [.portrait, .landscapeLeft, .landscapeRight]
            
            // Bug when popping videovc rotation should change
        }
        
        return .portrait
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
// - Discover
// - Find icons that are free to use
// - Acknowlegmenet screen (pods and icons and tmdb)
// - Test critical parts of app
// - Fix rotation bug
// - Final design refinements
// - Final cleanup of code
// - Reorder files in right folders
// - Update github page
// - Fix gravatar profile image
// - Placeholders
