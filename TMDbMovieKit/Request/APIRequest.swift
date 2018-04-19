//
//  APIRequest.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 16-04-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequestType {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var paramaters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

class APIRequest: APIRequestType {

    // MARK: - Properties

    let base: String

    let path: String

    let method: HTTPMethod
    
    let headers: [String: String]?

    let paramaters: [String: Any]?

    let body: [String: String]?

    // MARK: - Initialize

    init(base: String,
         path: String,
         method: HTTPMethod,
         headers: [String: String]? = nil,
         paramaters: [String: Any]? = nil,
         body: [String: String]? = nil)
    {
        self.base = base
        self.path = path
        self.method = method
        self.headers = headers
        self.paramaters = paramaters
        self.body = body
    }
}

// MARK: - URLRequestConvertible

extension APIRequest: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let url = try base.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if let paramaters = paramaters {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: paramaters)
        }
        
        if let body = body {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: body)
        }
        
        if let headers = headers {
            headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        }
        
        return urlRequest
    }
}

extension APIRequest {

    static func tmdbAPI(method: HTTPMethod, path: String, paramaters: [String: Any]?, body: [String: String]?) -> APIRequest {
        let baseString = "https://api.themoviedb.org/3/"
        let defaultParams: [String: Any] = ["api_key": TMDbSessionInfoStore().APIKey]
        let params = paramaters != nil ? defaultParams.merge(paramaters!) : defaultParams
        return APIRequest(base: baseString, path: path, method: method, paramaters: params, body: body)
    }
}
