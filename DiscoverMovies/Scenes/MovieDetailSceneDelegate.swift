//
//  MovieDetailSceneDelegate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 22/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

final class MovieDetailSceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // Implementing this method tells the system that the sample supports user-activity-based state restoration.
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        // This is the NSUserActivity that will be used to restore state when the scene reconnects.
        return scene.userActivity
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .backgroundColor()

        /// Grab the most relevant activiy from the system (Handoff or shortcut or notification) otherwise restore the previous state.
        guard let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity,
            let movieData = userActivity.userInfo?[NSUserActivity.MovieDetailDataKey] as? Data,
            let movie = try? JSONDecoder().decode(Movie.self, from: movieData) else {
                // We could add functionality to the movie detail view controller to be initialized with just the id of a movie.
                // Then it could fetch data if needed.
                fatalError("We should have the data to show the details of a movie")
        }

        let navigationController = UINavigationController(rootViewController: MovieDetailViewController(movie: movie, signedIn: false))
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
