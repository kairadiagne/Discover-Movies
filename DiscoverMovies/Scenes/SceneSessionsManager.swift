//
//  SceneManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/11/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit
import TMDbMovieKit

/// Manages all the scene session that are associated with the application.
final class SceneSessionsManager {

    // MARK: Properties

    /// The session that manages the primary scene if there is one.
    private(set) var primarySceneSession: UISceneSession?

    /// The UIApplication object of the app responsible for managing system level events.
    private let application: UIApplication

    // MARK: Initialize

    /// Initializes a new instance of `SceneManager`.
    /// - Parameter application: The application object of the app.
    init(application: UIApplication = UIApplication.shared) {
        self.application = application
    }

    /// Checks if there is already an open session responsible for showing the details for a specific movie.
    /// - Parameter movie: The movie that should be associate to the session.
    func existingSession(for movie: Movie) -> UISceneSession? {
        return application.openSessions.first { $0.stateRestorationActivity?.activityType == NSUserActivity.ActivityType.movieDetail.rawValue }
    }

    // MARK: Actions 

    func openScene(for movie: Movie, sourceScene: UIWindowScene, errorHandler: ((Error) -> Void)? = nil) {
        let existingSession = self.existingSession(for: movie)
        let movieDetailActivity = NSUserActivity.detailActivity(for: movie)
        let activtionRequestOptions = UIScene.ActivationRequestOptions()
        activtionRequestOptions.requestingScene = sourceScene

        application.requestSceneSessionActivation(existingSession, userActivity: movieDetailActivity, options: activtionRequestOptions, errorHandler: errorHandler)
    }

    func closeScene(from viewController: UIViewController) {
        guard let scene = viewController.view.window?.windowScene else { }
        let options = UIWindowSceneDestructionRequestOptions()
        options.windowDismissalAnimation = .commit
        UIApplication.shared.requestSceneSessionDestruction(scene.session, options: options, errorHandler: { error in
            // TODO: - Handle error
        })
    }
}

// MARK: - Convenience functions

// Find an existing scene that

// Request a new scene to be opened

// Request a scene to be activated

// Request a scene to be closed

//var activityType: String {
//       return Bundle.main.infoDictionary?["NSUserActivityTypes"].flatMap { ($0 as? [String])?.first } ?? ""
//   }

// We need to let each scene describe their capabilities, what kind of content they can work with.

// What are my activation conditions
// The app has two different type of windows:
// - A primary scene which should be able to handle anything
// - A secondary scene which only shows the details of a movie.

// Scenario 1:
// There is only on scene open which is a secondary scene.
// When only the secondayr scene is open it means the user can't do anything without opening a new primary window.
// In the advent where that user needs to open a push notification, deeplink from another app, or application shortcut item
// We need to make sure the secondary scene has a predicate that indicates that it cant do anything except things related to that movie.
// Which in our case is nothing. Therefore the system should decide to open up a new window

// There is multiple windows open but only one is primary
// Same thing should happen, only the primary scene should be able to handle the action.

// There are multiple primary scenes open.
// Let the system choose one based on which primary scene fulfills the most requirements.
