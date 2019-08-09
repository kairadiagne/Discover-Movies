//
//  RequestConfigurations.swift
//  Discover
//
//  Created by Kaira Diagne on 19-11-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Alamofire

struct ApiRequest: URLRequestConvertible {

    // MARK: Properties

    private let base: String

    private let path: String

    private let method: HTTPMethod

    private let headers: [String: String]

    private var paramaters: [String: AnyObject]

    private var additionalParamaters: [String: AnyObject]?

    private var body: [String: AnyObject]

    // MARK: Initialize

    init(base: String,
         path: String,
         method: HTTPMethod = .get,
         headers: [String: String] = [:],
         paramaters: [String: AnyObject] = [:],
         body: [String: AnyObject] = [:]) {
        self.base = base
        self.path = path
        self.method = method
        self.headers = headers
        self.paramaters = paramaters
        self.body = body
    }

    mutating func add(paramaters: [String: AnyObject]) {
        additionalParamaters = paramaters
    }

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try base.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        var paramsCopy = paramaters
        paramsCopy["api_key"] = Configuration.shared.apiKey as AnyObject

        if let additionalParamaters = additionalParamaters {
            paramsCopy = paramsCopy.merge(additionalParamaters)
        }

        if !paramsCopy.isEmpty {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: paramsCopy)
        }

        if !body.isEmpty {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: body)
        }

        if headers.isEmpty == false {
            headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        }

        return urlRequest
    }
}

extension ApiRequest {

    // MARK: - Authentication

    static func requestToken() -> ApiRequest {
        return ApiRequest(base: TMDbAPI.BaseURL, path: "authentication/token/new")
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

    // MARK - Details

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
