//
//  TMDbSignInRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

private struct Key {
    static let RequestToken = "request_token"
    static let SessionID = "session_id"
    static let APIKey = "api_key"
}

enum TMDbSignInRouter: URLRequestConvertible {
    case RequestToken(APIKey: String)
    case SessionID(String, APIKey: String)
    case UserInfo(String, APIKey: String)
    
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
            var parameters = [String: AnyObject]()
            
            switch self {
            case .RequestToken(let APIKey):
                parameters[Key.APIKey] = APIKey
                return ("authentication/token/new", parameters)
            case .SessionID(let token, let APIKey):
                parameters[Key.RequestToken] = token
                parameters[Key.APIKey] = APIKey
                return ("authentication/session/new", parameters)
            case .UserInfo(let sessionID, let APIKey):
                parameters[Key.SessionID] = sessionID
                parameters[Key.APIKey] = APIKey
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
  