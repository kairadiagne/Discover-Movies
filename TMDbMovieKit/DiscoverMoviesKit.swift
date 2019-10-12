//
//  Configuration.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

/// Holds the values
public struct DiscoverMoviesKit {

    static var shared: DiscoverMoviesKit {
        guard let shared = _shared else {
            fatalError("DiscoverMoviesKit not setup, call `Configuration.Configure(apiKey:)` before using the framwork.")
        }

        return shared
    }

    private static var _shared: DiscoverMoviesKit!

    /// The API key used to authenticate with the The Movie Database API.
    let apiKey: String

    /// The session manager responsible for creating and managing the requests in the app.
    let sessionManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        return SessionManager(configuration: config)
    }()

    /// Configures the shared instance of `Configuration` with a specified API key.
    ///
    /// - Parameter apiKey: The API key uses to authenticate with the The Movie Database API.
    public static func configure(apiKey: String) {
        _shared = DiscoverMoviesKit(apiKey: apiKey)
    }
}
