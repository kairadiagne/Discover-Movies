//
//  Configuration.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public final class DiscoverMoviesKit {

    static var shared: DiscoverMoviesKit {
        guard let shared = _shared else {
            fatalError("DiscoverMoviesKit not setup, call `Configuration.Configure(apiKey:)` before using the framwork.")
        }

        return shared
    }

    private static var _shared: DiscoverMoviesKit!

    /// The API key used to authenticate with the The Movie Database API v3.
    let apiKey: String

    /// The API key for read only access with The Movie Database API v4.
    let readOnlyApiKey: String

    /// The session manager responsible for creating and managing the requests in the app.
    let sessionManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        let sessionManager = SessionManager(configuration: config)
        sessionManager.adapter = MovieDBRequestAdapter()
        return sessionManager
    }()

    private(set) var persistentContainer: MovieKitPersistentContainer!

    init(apiKey: String, readOnlyApiKey: String) {
        self.apiKey = apiKey
        self.readOnlyApiKey = readOnlyApiKey
    }

    func register(persistentContainer: MovieKitPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    /// Configures the shared instance of `Configuration` with a specified API key.
    ///
    /// - Parameter apiKey: The API key uses to authenticate with the The Movie Database API.
    public static func configure(apiKey: String, readOnlyApiKey: String) {
        _shared = DiscoverMoviesKit(apiKey: apiKey, readOnlyApiKey: readOnlyApiKey)
    }
}
