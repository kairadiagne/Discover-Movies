//
//  APIRequest+TMDB.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 13/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

extension ApiRequest {

    // MARK: Properties

    static let tmdbBaseURLV3 = "https://api.themoviedb.org/3/"
    static let tmdbBaseURLV4 = "https://api.themoviedb.org/4/"

    // MARK: - Authentication

    static func requestToken(redirectURL: String) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV4, path: "auth/request_token", method: .post, body: ["redirect_to": redirectURL as AnyObject] )
    }

    static func createAccessToken(requestToken: String) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV4, path: "auth/access_token", method: .post, paramaters: ["request_token": requestToken as AnyObject])
    }

    static func getUser(sessionID: String) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV3, path: "account", paramaters: ["session_id": sessionID as AnyObject])
    }

    // MARK: - Movie List

    static func topList(list: String) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV3, path: "movie/\(list)")
    }

    static func accountList(_ list: String, userID: Int, sessionID: String) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV3, path: "account/\(userID)/\(list)/movies", paramaters: ["session_id": sessionID as AnyObject])
    }

    static func similarMovies(movieID: Int) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV3, path: "movie/\(movieID)/similar")
    }

    static func search() -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV3, path: "search/movie")
    }

    // MARK: - Details

    static func movieDetail(movieID: Int) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV3, path: "movie/\(movieID)", paramaters: ["append_to_response": "credits,trailers" as AnyObject])
    }

    static func review(movieID: Int) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV3, path: "movie/\(movieID)/reviews")
    }

    static func accountState(movieID: Int, sessionID: String) -> ApiRequest {
        let params: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        return ApiRequest(base: tmdbBaseURLV3, path: "movie/\(movieID)/account_states", paramaters: params)
    }

    static func setMovieStatus(status: Bool, movieID: Int, in list: String, userID: Int, sessionID: String) -> ApiRequest {
        let params: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        let body: [String: AnyObject] = ["media_type": "movie" as AnyObject, "media_id": movieID as AnyObject, list: status as AnyObject]
        return ApiRequest(base: tmdbBaseURLV3, path: "account/\(userID)/\(list)", paramaters: params, body: body)
    }

    static func person(with personID: Int) -> ApiRequest {
        return ApiRequest(base: tmdbBaseURLV3, path: "person/\(personID)", paramaters: ["append_to_response": "movie_credits" as AnyObject])
    }
}
