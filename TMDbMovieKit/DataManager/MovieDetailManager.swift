//
//  MovieDetailManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class MovieDetailManager: DataManager<TMDBMovieInfo> {
    
    // MARK: - Properties

    public var movieInfo: TMDBMovieInfo? {
        return cachedData.data
    }

    /// The state of the movie in the favorites and watch list.
    public private(set) var accountState: TMDBAccountState?

    /// The identifier of the movie for which to get the details.
    private let movieID: Int

    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.movieID = movieID
        super.init(request: ApiRequest.movieDetail(movieID: movieID), refreshTimeOut: 0, cacheIdentifier: "\(movieID)")
    }

    /// Changes the status of the movie in the specified list.
    /// - Parameter list: The list to add or remove the movie to.
    /// - Parameter status: True will add the movie to the list, false will remove the movie from the list.
    public func toggleStatusOfMovieInList(_ list: TMDbAccountList, status: Bool) {
    }

    /// Loads the status fo the movie in the watchlist and favoriteslist.
    public func loadAccountState() {
    }
}
