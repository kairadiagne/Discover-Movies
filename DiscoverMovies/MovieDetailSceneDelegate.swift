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

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return scene.userActivity
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        guard let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity else {
            return
        }

        // typed user activities
        guard let movieData = userActivity.userInfo?[Movie.OpenMovieDetailInfoKey] as? Data else {
            return
        }

        guard let movie = try? JSONDecoder().decode(Movie.self, from: movieData) else {
            return
        }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .backgroundColor()

        let navigationController = UINavigationController(rootViewController: DetailViewController(movie: movie, signedIn: false))
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
