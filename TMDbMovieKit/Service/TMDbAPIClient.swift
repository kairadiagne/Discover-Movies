//
//  TMDbAPIClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

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

class TMDbAPIClient {
    
    struct URL {
        static let Base = "https://api.themoviedb.org/3/"
        static let BaseImage = "https://image.tmdb.org/t/p/"
        static let Authenticate = "https://www.themoviedb.org/authenticate/"
        static let NewSession = "https://api.themoviedb.org/3/authentication/session/new/"
        static let Gravatar = "http://www.gravatar.com/avatar/"
    }

    var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    var sessionID: String? {
        return TMDbSessionInfoStore().sessionID
    }
    
    var userID: Int? {
        return TMDbSessionInfoStore().user?.userID
    }
    
}

public enum TMDbAccountList: String {
    case Favorites = "favorite"
    case Watchlist = "watchlist"
}

public enum TMDbToplist: String {
    case Popular = "popular"
    case TopRated = "top_rated"
    case Upcoming = "upcoming"
    case NowPlaying = "now_playing"
}



    


    









