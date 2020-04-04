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

    // MARK: Dependencies

    /// The session used through the app to perform network request.
    let session: Session
    
    /// The persistent container that serves as the Core Data stack of the app.
    private(set) var persistentContainer: MovieKitPersistentContainer!
        
    /// The access token store instance used throughout the app to provide acces to the token.
    let accessTokenStore = AccessTokenStore()
      
    // MARK: Initialize

    init(apiReadOnlyAccessToken: String) {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        let requestAdapter = MovieDBRequestAdapter(accessTokenStore: self.accessTokenStore, readOnlyAccessToken: apiReadOnlyAccessToken)
        session = Session(configuration: config, interceptor: requestAdapter)
    }

    func register(persistentContainer: MovieKitPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    /// Configures the shared instance of `Configuration` with a specified API key.
    ///
    /// - Parameter apiReadOnlyAccessToken: The read only access token used for read only access to the Movie Databse v3 and v4 API.
    public static func configure(apiReadOnlyAccessToken: String) {
        _shared = DiscoverMoviesKit(apiReadOnlyAccessToken: apiReadOnlyAccessToken)
    }
}
