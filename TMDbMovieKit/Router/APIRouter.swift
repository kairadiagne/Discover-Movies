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
    case get(endpoint: String, queryParams: [String: AnyObject])
    case post(endpoint: String, queryParams: [String: AnyObject], bodyParams: [String: AnyObject])
    
    var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .get(let endpoint, _):
            return endpoint
        case .post(let endpoint, _, _):
            return endpoint
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try TMDbAPI.BaseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .get(_, var queryParams):
            queryParams["api_key"] = APIKey as AnyObject?
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParams)
        case .post(_, var queryParams, let bodyParams):
            queryParams["api_key"] = APIKey as AnyObject?
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParams)
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: bodyParams)
        }
        
     return urlRequest
    }
    
}
    





    
    
    
    



