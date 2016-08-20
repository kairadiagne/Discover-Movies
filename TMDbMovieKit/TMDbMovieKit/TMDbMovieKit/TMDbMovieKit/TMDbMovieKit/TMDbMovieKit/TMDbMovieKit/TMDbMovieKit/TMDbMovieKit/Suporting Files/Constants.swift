//
//  Constants.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-03-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

struct TMDbAPI {
    static let BaseURL = "https://api.themoviedb.org/3/"
    static let ImageBaseURL = "https://image.tmdb.org/t/p/"
    static let AuthenticateURL = "https://www.themoviedb.org/authenticate/"
    static let SessionURL = "https://api.themoviedb.org/3/authentication/session/new/"
    static let GravatarBaseURLString = "http://www.gravatar.com/avatar/"
}

private struct Key {
    static let ReleaseYear = "primary_release_year"
    static let Genre = "with_genres"
    static let Vote = "vote_average.gte"
    static let Sort = "sort_by"
    static let Page = "page"
    static let SessionID = "session_id"
    static let MediaID = "media_id"
    static let MediaType = "media_type"
    static let Favorite = "favorite"
    static let WatchList = "watchlist"
    static let StatusCode = "status_code"
    static let Query = "query"
    static let APIKey = "api_key"
}
