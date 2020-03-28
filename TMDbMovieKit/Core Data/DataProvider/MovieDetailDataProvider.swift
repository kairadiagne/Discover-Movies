//
//  MovieDetailManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Alamofire
import CoreData

public final class MovieDetailDataProvider {
    
    // MARK: - Properties

    /// property througg which the movie can be observed

    /// The identifier of the movie for which to get the details.
    private let movieID: Int64

    /// The persistent container that encapsulates the Core Data Stack.
    private let persistentContainer: MovieKitPersistentContainer

    /// The session used to make requests to the movie database API.
    private let session: Session

    // MARK: Initialize

    public convenience init (movieID: Int) {
        self.init(movieID: Int64(movieID), persistentContainer: DiscoverMoviesKit.shared.persistentContainer, session: DiscoverMoviesKit.shared.session)
    }

    init(movieID: Int64, persistentContainer: MovieKitPersistentContainer, session: Session) {
        self.movieID = movieID
        self.persistentContainer = persistentContainer
        self.session = session
    }

    // MARK: Public API

    /// Changes the status of the movie in the specified list.
    /// - Parameter list: The list to add or remove the movie to.
    /// - Parameter status: True will add the movie to the list, false will remove the movie from the list.
    public func toggleStatusOfMovieInList(_ list: String, status: Bool) {
    }

    /// Loads the status fo the movie in the watchlist and favoriteslist.
    public func loadAccountState() {
    }

    // MARK: Old

    public var movieInfo: TMDBMovieInfo? {
        return nil
    }

    /// The state of the movie in the favorites and watch list.
    public private(set) var accountState: TMDBAccountState?

    //        super.init(request: ApiRequest.movieDetail(movieID: movieID), refreshTimeOut: 0, cacheIdentifier: "\(movieID)")
}
