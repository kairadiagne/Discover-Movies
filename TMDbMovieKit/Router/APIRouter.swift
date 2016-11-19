//
//  APIRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case request(config: RequestConfiguration, queryParams: [String: AnyObject]?, bodyParams: [String: AnyObject]?)

    var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    var path: String {
        switch self {
        case .request(let config, _, _):
            return config.endpoint
        }
    }
    
    var method: String {
        switch self {
        case .request(let config, _, _):
            return config.method.rawValue
        }
    }
        
    var queryParams: [String: AnyObject]? {
        switch self {
        case .request(let config, let queryParams, _):
            var params = queryParams ?? [:]
            
            if let defaultParams = config.defaultParams {
                params = params.merge(defaultParams)
            }
            
            params["api_key"] = APIKey as AnyObject?
            
            return params
        }
    }
    
    var bodyParams: [String: AnyObject]? {
        switch self {
        case .request(_, _, let bodyParams):
            return bodyParams
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .request(let config, _, _):
            return config.headers
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try TMDbAPI.BaseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // Set method 
        urlRequest.httpMethod = method
        
        // Encode Query Params
        if let queryParams = queryParams {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParams)
        }
        
        // Encode Body Params
        if let bodyParams = bodyParams {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: bodyParams)
        }
        
        // Set headers
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return urlRequest
    }
}


