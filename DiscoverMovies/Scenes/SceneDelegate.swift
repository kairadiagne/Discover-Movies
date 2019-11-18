//
//  SceneDelegate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 18/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var tabBarController: DiscoverTabBarController!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .backgroundColor()
        Theme.apply()

        tabBarController = DiscoverTabBarController(dependencyContainer: DependencyContainer.shared)
        window?.rootViewController = tabBarController

        if let userActivity = connectionOptions.userActivities.first ?? scene.session.stateRestorationActivity {
            setupScene(with: userActivity)
        }

        window?.makeKeyAndVisible()
    }

    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return scene.userActivity
    }

    private func setupScene(with userActivity: NSUserActivity) {
        guard let moviedData = userActivity.userInfo?[NSUserActivity.MovieDetailDataKey] as? Data,
            let movie = try? JSONDecoder().decode(Movie.self, from: moviedData),
            let navigationControler = tabBarController.viewControllers?.first as? UINavigationController else {
                return
        }

        tabBarController.selectedIndex = 0
        let movieDetailViewController = MovieDetailViewController(movie: movie, signedIn: false)
        navigationControler.pushViewController(movieDetailViewController, animated: false)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        guard let detailViewController = tabBarController.viewControllers?.first?.navigationController?.visibleViewController as? MovieDetailViewController,
            let movie = detailViewController.movie as? Movie else {
            return
        }

        scene.session.stateRestorationActivity = NSUserActivity.detailActivity(for: movie)
    }
}
