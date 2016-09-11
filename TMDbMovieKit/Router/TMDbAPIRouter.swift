//
//  TMDbAPIRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

enum TMDbAPIRouter: URLRequestConvertible {
    case get(endpoint: String, parameters: [String: AnyObject])
    case post(endpoint: String, parameters: [String: AnyObject], body: [String: AnyObject])
    
    var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    var URLRequest: NSMutableURLRequest {
        
        var method: Alamofire.Method {
            switch self {
            case .get:
                return .GET
            case .post:
                return .POST
            }
        }
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            
            switch self {
            case .get(let endpoint , var parameters):
                parameters["api_key"] = APIKey as AnyObject?
                return (endpoint, parameters)
            case .post(let endpoint, var parameters, _):
                parameters["api_key"] = APIKey as AnyObject?
                return (endpoint, parameters)
            }
            
        }()
    
        
        let body: [String: AnyObject]? = {
            switch self {
            case .post(_, _, let body):
                return body
            default: return nil
            }
        }()
    
        var URL = Foundation.URL(string: TMDbAPI.BaseURL)!
        URL = URL.appendingPathComponent(result.path)
        let URLRequest = Foundation.URLRequest(url: URL)
        
        let QueryEncoding = Alamofire.ParameterEncoding.URLEncodedInURL
        let JSONEncoding = Alamofire.ParameterEncoding.JSON
        let (encodeRequest, _) = QueryEncoding.encode(URLRequest, parameters: result.parameters)
        let (finalRequest, _) = JSONEncoding.encode(encodeRequest.URLRequest, parameters: body)
        finalRequest.HTTPMethod = method.rawValue
        
        return finalRequest
    }
}
