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
            let apiKey = dictionary["APIKey"] as? String,
            let readOnlyAPIKey = dictionary["APIKeyV4"] as? String
            else {
                fatalError("Failed to read tmdb api key from the plist file")
        }

        DiscoverMoviesKit.configure(apiKey: apiKey, readOnlyApiKey: readOnlyAPIKey)
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
