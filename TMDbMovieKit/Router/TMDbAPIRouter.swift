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
    case GET(endpoint: String, parameters: [String: AnyObject])
    case POST(endpoint: String, parameters: [String: AnyObject], body: [String: AnyObject])
    
    var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    var URLRequest: NSMutableURLRequest {
        
        var method: Alamofire.Method {
            switch self {
            case .GET:
                return .GET
            case .POST:
                return .POST
            }
        }
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            
            switch self {
            case GET(let endpoint , var parameters):
                parameters["api_key"] = APIKey
                return (endpoint, parameters)
            case POST(let endpoint, var parameters, _):
                parameters["api_key"] = APIKey
                return (endpoint, parameters)
            }
            
        }()
        
        let body: [String: AnyObject]? = {
            switch self {
            case .POST(_, _, let body):
                return body
            default: return nil
            }
        }()
    
        var URL = NSURL(string: TMDbAPI.BaseURL)!
        URL = URL.URLByAppendingPathComponent(result.path)
        let URLRequest = NSURLRequest(URL: URL)
        
        let QueryEncoding = Alamofire.ParameterEncoding.URLEncodedInURL
        let JSONEncoding = Alamofire.ParameterEncoding.JSON
        let (encodeRequest, _) = QueryEncoding.encode(URLRequest, parameters: result.parameters)
        let (finalRequest, _) = JSONEncoding.encode(encodeRequest.URLRequest, parameters: body)
        finalRequest.HTTPMethod = method.rawValue
        
        return finalRequest
    }
}
