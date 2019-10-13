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

    // A container that holds all the apps dependencies.
    private lazy var dependencyContainer = DependencyContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .backgroundColor()

        guard
            let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
            let apiKey = dictionary["APIKey"] as? String,
            let readOnlyAPIKey = dictionary["APIKeyV4"] as? String
        else {
            fatalError("Failed to read tmdb api key from the plist file")
        }

        DiscoverMoviesKit.configure(apiKey: apiKey, readOnlyApiKey: readOnlyAPIKey)

        let tabBarController = DiscoverTabBarController(dependencyContainer: dependencyContainer)
        window?.rootViewController = tabBarController

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        Theme.apply()

        return true
    }
}
