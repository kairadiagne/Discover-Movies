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
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        guard
            let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject],
            let readOnlyAPIKey = dictionary["APIKeyV4"] as? String
            else {
                fatalError("Failed to read tmdb api key from the plist file")
        }

        // Needs to be called before anything else
        DiscoverMoviesKit.configure(apiReadOnlyAccessToken: readOnlyAPIKey)

        // Creates the default container inside of the moviekit framwork.
        MovieKitPersistentContainer.createDefaultContainer { }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configurationName = "Default Configuration"
        return .init(name: configurationName, sessionRole: connectingSceneSession.role)
    }
}
