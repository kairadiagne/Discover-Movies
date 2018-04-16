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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .backgroundColor()
        appCoordinator = AppCoordinator(window: window!)
        
        window?.makeKeyAndVisible()
        
        appCoordinator.start()
        
        Theme.apply()

        return true
    }
}
