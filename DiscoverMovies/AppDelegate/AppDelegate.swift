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
        Theme.applyTheme()
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let keys = NSDictionary(contentsOfFile: path), let APIKey = keys["APIKey"] as? String {
            TMDbSessionManager.shared.registerAPIKey(APIKey)
        }
        
        let topListViewController = TopListViewController()
        let frontViewController = UINavigationController(rootViewController: topListViewController)
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
        }
        
        return .portrait
    }

}

