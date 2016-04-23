//
//  TMDbSignInRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

enum TMDbSignInRouter: URLRequestConvertible {
    case RequestToken
    case SessionID(String)
    case UserInfo(String)
    
    var URLRequest: NSMutableURLRequest {
        var method: Alamofire.Method {
            switch self {
            case .RequestToken:
                return .GET
            case .SessionID:
                return .GET
            case .UserInfo:
                return .GET
            }
        }
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            var parameters: [String: AnyObject] = [TMDbRequestKey.API: TMDbAPI.APIKey]
            
            switch self {
            case .RequestToken:
                return ("authentication/token/new", parameters)
            case .SessionID(let token):
                parameters[TMDbRequestKey.RequestToken] = token
                return ("authentication/session/new", parameters)
            case .UserInfo(let sessionID):
                parameters[TMDbRequestKey.SessionID] = sessionID
                return ("account", parameters)
            }
        }()
        
        var URL = NSURL(string: TMDbAPI.BaseURL)!
        URL = URL.URLByAppendingPathComponent(result.path)
        let URLRequest = NSURLRequest(URL: URL)
        let QueryEncoding = Alamofire.ParameterEncoding.URLEncodedInURL
        let (encodeRequest, _) = QueryEncoding.encode(URLRequest, parameters: result.parameters) // Query
        encodeRequest.HTTPMethod = method.rawValue
        print(encodeRequest)
        return encodeRequest
    }
    
}
  