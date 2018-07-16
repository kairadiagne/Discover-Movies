//
//  RequestBuilder.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 27-05-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

struct RequestBuilder: URLRequestConvertible {

    // MARK: - Properties

    private let base: String

    private let path: String

    private let method: HTTPMethod

    private(set) var headers: [String: String]

    private(set) var paramaters: [String: AnyObject]

    private(set) var body: [String: String]?

    private let sessionInfo: SessionInfoReading

    // MARK: - Initialize

    init(base: String,
         path: String,
         method: HTTPMethod,
         headers: [String: String] = [:],
         paramaters: [String: AnyObject] = [:],
         body: [String: String] = [:],
         sessionInfo: SessionInfoReading = SessionInfoService()) {
        self.base = base
        self.path = path
        self.method = method
        self.headers = headers
        self.paramaters = paramaters
        self.body = body
        self.sessionInfo = sessionInfo
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try base.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        var paramsCopy = paramaters
        paramsCopy["api_key"] = sessionInfo.APIKey as AnyObject

        if paramsCopy.isEmpty == false {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: paramsCopy)
        }

        if body?.isEmpty == false {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: body)
        }

        if headers.isEmpty == false {
            headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        }

        return urlRequest
    }
}

// MARK: - Requests

extension RequestBuilder {

    static let basePath = TMDbAPI.BaseURL

    static func requestToken() -> RequestBuilder {
        return RequestBuilder(base: basePath, path: "authentication/session/new", method: .get)
    }

    static func sessionToken(requestToken: String) -> RequestBuilder {
        let params: [String: AnyObject] = ["request_token": requestToken as AnyObject]
        return RequestBuilder(base: basePath, path: "authentication/token/new", method: .get, paramaters: params)
    }

    static func user(sessionID: String) -> RequestBuilder {
        let params: [String: String] = ["session_id": sessionID]
        return RequestBuilder(base: basePath, path: "account", method: .get, paramaters: params as [String: AnyObject])
    }

    static func topList(list: TMDbTopList, page: Int) -> RequestBuilder {
        let params = RequestBuilder.generatePageDict(page: page)
        return RequestBuilder(base: basePath, path: "movie/\(list.name)", method: .get, paramaters: params)
    }

    static func similarMovies(movieID: Int, page: Int) -> RequestBuilder {
        let params = RequestBuilder.generatePageDict(page: page)
        return RequestBuilder(base: basePath, path: "movie/\(movieID)/similar", method: .get, paramaters: params)
    }

    static func search(query: String) -> RequestBuilder { // Page
        return RequestBuilder(base: basePath, path: "search/movie", method: .get, paramaters: ["query": query as AnyObject])
    }

    static func movieDetail(movieID: String) -> RequestBuilder {
        let params: [String: AnyObject] = ["append_to_response": "credits,trailers" as AnyObject]
        return RequestBuilder(base: basePath, path: "movie/\(movieID)", method: .get, paramaters: params)
    }

    static func reviews(movieID: Int, page: Int) -> RequestBuilder {
        let params = RequestBuilder.generatePageDict(page: page)
        return RequestBuilder(base: basePath, path: "movie/\(movieID)/reviews", method: .get, paramaters: params)
    }

    static func accountState(movieID: String) -> RequestBuilder {
        return RequestBuilder(base: basePath, path: "movie/\(movieID)/account_states", method: .get)
    }

    static func listStatus(userID: String, list: TMDbAccountList) -> RequestBuilder {
        return RequestBuilder(base: basePath, path: "account/\(userID)/\(list.name)", method: .get)
    }

    static func accountList(userID: Int, sessionID: String, list: TMDbAccountList, page: Int) -> RequestBuilder {
        var params = ["session_id": sessionID as AnyObject]
        params = params.merge(generatePageDict(page: page))
        return RequestBuilder(base: basePath, path: "account/\(userID)/\(list.name)/movies", method: .get, paramaters: params)
    }

    static func person(personID: Int) -> RequestBuilder {
        let params = ["append_to_response": "movie_credits"]
        return RequestBuilder(base: basePath, path: "person/\(personID)", method: .get, paramaters: params as [String : AnyObject])
    }

    // MARK: - Utils

    static func generatePageDict(page: Int) -> [String: AnyObject] {
        return ["page": page as AnyObject]
    }
}
