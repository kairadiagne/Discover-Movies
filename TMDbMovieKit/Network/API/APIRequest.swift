//
//  RequestConfigurations.swift
//  Discover
//
//  Created by Kaira Diagne on 19-11-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Alamofire

/// A type used to construct a URLRequest.
struct ApiRequest: URLRequestConvertible {

    // MARK: Properties

    let base: String

    let path: String

    let method: HTTPMethod

    let headers: [String: String]

    private(set) var paramaters: [String: AnyObject]

    private(set) var additionalParamaters: [String: AnyObject]?

    private(set) var body: [String: AnyObject]

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
        if let additionalParamaters = additionalParamaters {
            paramsCopy.merge(additionalParamaters) { _, new in new }
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
