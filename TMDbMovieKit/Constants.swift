//
//  Constants.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDbAPI {
    static let APIKey = "b23b0ad7a6c11640e4e232527f2e6d67"
    static let BaseURL = "https://api.themoviedb.org/3/"
    static let ImageBaseURL = "https://image.tmdb.org/t/p/"
    static let AuthenticateURL = "https://www.themoviedb.org/authenticate/"
    static let SessionURL = "http://api.themoviedb.org/3/authentication/session/new/"
    static var GravatarBaseURLString = "http://www.gravatar.com/avatar/"
}

public struct TMDbRequestKey {
    static let API = "api_key"
    static let ReleaseYear = "primary_release_year"
    static let Genre = "with_genres"
    static let VoteAverage = "vote_average.gte"
    static let Sort = "sort_by"
    static let Page = "page"
    static let RequestToken = "request_token"
    static let SessionID = "session_id"
    static let MediaID = "media_id"
    static let MediaType = "media_type"
    static let Favorite = "favorite"
    static let Watchlist = "watchlist"
    static let StatusCode = "status_code"
    static let Query = "query"
}

public struct TMDbResponseKey {
    static let Results = "results"
    static let RequestToken = "request_token"
    static let ExpirationDate = "expires_at"
    static let SessionID = "session_id"
    static let Page = "page"
    static let TotalPages = "total_pages"
    static let Favorite = "favorite"
    static let WatchList = "watchlist"
}
