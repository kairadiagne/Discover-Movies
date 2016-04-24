//
//  TMDbPeopleRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

private struct Key {
    static let Page = "page"
    static let Query = "query"
    static let APIKey = "api_key"
}

enum TMDbPeopleRouter: URLRequestConvertible {
    case PeopleList(list: String, page: Int?, APIKey: String)
    case PersonWithName(name: String, page: Int?, APIKey: String)
    case PersonInfo(personID: Int, APIKey: String)
    
    var URLRequest: NSMutableURLRequest {
        
        var method: Alamofire.Method {
            switch self {
            case .PeopleList:
                return .GET
            case .PersonWithName:
                return .GET
            case .PersonInfo:
                return .GET
            }
        }
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            var paramaters = [String: AnyObject]()
            
            switch self {
            case .PeopleList(let list, let page, let APIKey):
                if let page = page { paramaters[Key.Page] = page }
                paramaters[Key.APIKey] = APIKey
                return ("person/\(list)", paramaters)
            case .PersonWithName(let name, let page, let APIKey):
                paramaters[Key.Query] = name
                if let page =  page { paramaters[Key.Page] = page }
                paramaters[Key.APIKey] = APIKey
                return ("search/person", paramaters)
            case .PersonInfo(let id, let APIKey ):
                paramaters[Key.APIKey] = APIKey
                return ("person/\(id)", paramaters)
            }
        }()
        
        var URL = NSURL(string: TMDbAPI.BaseURL)!
        URL = URL.URLByAppendingPathComponent(result.path)
        let URLRequest = NSURLRequest(URL: URL)
        let QueryEncoding = Alamofire.ParameterEncoding.URLEncodedInURL
        let (encodeRequest, _) = QueryEncoding.encode(URLRequest, parameters: result.parameters) 
        encodeRequest.HTTPMethod = method.rawValue
        print(encodeRequest)
        return encodeRequest
    }
}


