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
                parameters["api_key"] = ""
                return (endpoint, parameters)
            case POST(let endpoint, var parameters, _):
                parameters["api_key"] = ""
                return (endpoint, parameters)
            }
            
        }()
        
        
        // BODY
        
        var URL = NSURL(string: TMDbAPI.BaseURL)!
        URL = URL.URLByAppendingPathComponent(result.path)
        let URLRequest = NSURLRequest(URL: URL)
        let QueryEncoding = Alamofire.ParameterEncoding.URLEncodedInURL
        let JSONEncoding = Alamofire.ParameterEncoding.JSON
        let (encodeRequest, _) = QueryEncoding.encode(URLRequest, parameters: result.parameters) // Query
//        let (finalRequest, _) = JSONEncoding.encode(encodeRequest.URLRequest, parameters: body) // Body
        finalRequest.HTTPMethod = method.rawValue
        print(finalRequest)
        return finalRequest
        
    }
}


//        
//        let result: (path: String, parameters: [String: AnyObject]?) = {
//       
//        
//        
//        let body: [String: AnyObject]? = {
//            switch self {
//            case .AddRemoveFromList(let body, _, _, _, _): return body
//            default: return nil
//            }
//        }()
//        
//     
//    }
//}