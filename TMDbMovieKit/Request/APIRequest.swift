//
//  APIRequest.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 16-04-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

class APIRequest: URLRequestConvertible {

    // MARK: - Properties

    private let baseURL: String

    private let path: String

    private let method: HTTPMethod

    private let paramaters: [String: Any]?

    private let body: [String: Any]?

    // MARK: - Initialize

    init(baseURL: String, path: String, method: HTTPMethod, paramaters: [String: Any]?, body: [String: Any]?) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.paramaters = paramaters
        self.body = body
    }

    // MARK: - URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = try TMDbAPI.BaseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        if let paramaters = paramaters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: paramaters)
        }

        if let body = body {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: body)
        }

        return urlRequest
    }
}

extension APIRequest {

    static func tmdbAPI(method: HTTPMethod, path: String, paramaters: [String: Any]?, body: [String: Any]?) -> APIRequest {
        let baseURLString = "https://api.themoviedb.org/3/"
        let defaultParams: [String: Any] = ["api_key": TMDbSessionInfoStore().APIKey]
        let params = paramaters != nil ? defaultParams.merge(paramaters!) : defaultParams
        return APIRequest(baseURL: baseURLString, path: path, method: method, paramaters: params, body: body)
    }
}
