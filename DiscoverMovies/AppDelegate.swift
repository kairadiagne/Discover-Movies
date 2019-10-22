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

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let configurationName: String
        if options.userActivities.first?.activityType == Movie.OpenMovieDetailActivityType {
            configurationName = "Movie Detail Configuration"
        } else {
            configurationName = "Default Configuration"
        }
        return .init(name: configurationName, sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
