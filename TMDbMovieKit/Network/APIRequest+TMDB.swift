//
//  APIRequest+TMDB.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 13/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

extension ApiRequest {

    // MARK: - Authentication

    static func requestToken(redirectURL: String) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURLV4, path: "auth/request_token", method: .post, body: ["redirect_to": redirectURL as AnyObject] )
    }

    static func authenticate(token: String) -> ApiRequest {
        return ApiRequest(base: "https://www.themoviedb.org/authenticate", path: "\(token)")
    }

    static func requestSessionToken(token: String) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "authentication/session/new", paramaters: ["request_token": token as AnyObject])
    }

    static func getUser(sessionID: String) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "account", paramaters: ["session_id": sessionID as AnyObject])
    }

    // MARK: - Movie List

    static func topList(list: TMDbList) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "movie/\(list.name)")
    }

    static func accountList(_ list: TMDbAccountList, userID: Int, sessionID: String) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "account/\(userID)/\(list.name)/movies", paramaters: ["session_id": sessionID as AnyObject])
    }

    static func similarMovies(movieID: Int) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "movie/\(movieID)/similar")
    }

    static func search() -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "search/movie")
    }

    // MARK: - Details

    static func movieDetail(movieID: Int) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "movie/\(movieID)", paramaters: ["append_to_response": "credits,trailers" as AnyObject])
    }

    static func review(movieID: Int) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "movie/\(movieID)/reviews")
    }

    static func accountState(movieID: Int, sessionID: String) -> ApiRequest {
        let params: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        return ApiRequest(base: TMDbAPI.BaseURL, path: "movie/\(movieID)/account_states", paramaters: params)
    }

    static func setMovieStatus(status: Bool, movieID: Int, in list: TMDbAccountList, userID: Int, sessionID: String) -> ApiRequest {
        let params: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        let body: [String: AnyObject] = ["media_type": "movie" as AnyObject, "media_id": movieID as AnyObject, list.name: status as AnyObject]
        return ApiRequest(base: TMDbAPI.BaseURL, path: "account/\(userID)/\(list.name)", paramaters: params, body: body)
    }

    static func person(with personID: Int) -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "person/\(personID)", paramaters: ["append_to_response": "movie_credits" as AnyObject])
    }
}
