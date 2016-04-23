//
//  TMDbMovieRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

enum TMDbMovieRouter: URLRequestConvertible {
    case TopList(String, Int?)
    case Discover(String?, Int?, Float?, Int?)
    case SearchByTitle(String, Int?)
    case List(String, String, Int, Int?)
    case SimilarMovies(Int, Int?)
    case Reviews(Int, Int?)
    case Videos(Int)
    case AccountState(Int, String)
    case AddRemoveFromList([String: AnyObject], Int,  String, String)
    
    var URLRequest: NSMutableURLRequest {
        var method: Alamofire.Method {
            switch self {
            case .TopList:
                return .GET
            case .Discover:
                return .GET
            case .SearchByTitle:
                return .GET
            case .List:
                return .GET
            case .SimilarMovies:
                return .GET
            case .Reviews:
                return .GET
            case .Videos:
                return .GET
            case .AccountState:
                return .GET
            case .AddRemoveFromList:
                return .POST
            }
        }
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            // TMDb only supports sending the API key as a query paramater and not through the header.
            var parameters: [String: AnyObject] = [TMDbRequestKey.API: TMDbAPI.APIKey]
        
            switch self {
            case .TopList(let list, let page):
                if let page = page { parameters[TMDbRequestKey.Page] = page }
                return ("movie/\(list)", parameters)
            case .Discover(let year, let genre, let voteAverage, let page):
                if let year = year { parameters[TMDbRequestKey.ReleaseYear] = year }
                if let genre = genre { parameters[TMDbRequestKey.Genre] = genre }
                if let voteAverage = voteAverage { parameters[TMDbRequestKey.VoteAverage] = voteAverage }
                if let page = page { parameters[TMDbRequestKey.Page] = page }
                parameters[TMDbRequestKey.Sort] = "popularity.desc"
                return ("discover/movie", parameters)
            case .SearchByTitle(let title, let page):
                parameters[TMDbRequestKey.Query] = title
                if let page = page { parameters[TMDbRequestKey.Page] = page }
                return ("search/movie", parameters)
            case .List(let list, let sessionID, let accountID, let page):
                parameters[TMDbRequestKey.SessionID] = sessionID
                if let page = page { parameters[TMDbRequestKey.Page] = page }
                return ("account/\(accountID)/\(list)/movies", parameters)
            case .SimilarMovies(let movieID, let page):
                if let page = page { parameters[TMDbRequestKey.Page] = page }
                return ("movie/\(movieID)/similar", parameters)
            case .Reviews(let movieID, let page):
                if let page = page { parameters[TMDbRequestKey.Page] = page }
                return ("movie/\(movieID)/reviews", parameters)
            case .Videos(let movieID):
                return ("movie/\(movieID)/videos", parameters)
            case .AccountState(let movieID, let sessionID):
                parameters[TMDbRequestKey.SessionID] = sessionID
                return ("movie/\(movieID)/account_states", parameters)
            case .AddRemoveFromList(_, let accountID, let list, let sessionID):
                parameters[TMDbRequestKey.SessionID] = sessionID
                return("account/\(accountID)/\(list)", parameters)
            }
        }()
        
        let body: [String: AnyObject]? = {
            switch self {
            case .AddRemoveFromList(let body, _, _, _): return body
            default: return nil
            }
        }()
        
        var URL = NSURL(string: TMDbAPI.BaseURL)!
        URL = URL.URLByAppendingPathComponent(result.path)
        let URLRequest = NSURLRequest(URL: URL)
        let QueryEncoding = Alamofire.ParameterEncoding.URLEncodedInURL
        let JSONEncoding = Alamofire.ParameterEncoding.JSON
        let (encodeRequest, _) = QueryEncoding.encode(URLRequest, parameters: result.parameters) // Query
        let (finalRequest, _) = JSONEncoding.encode(encodeRequest.URLRequest, parameters: body) // Body
        finalRequest.HTTPMethod = method.rawValue
        print(finalRequest)
        return finalRequest
    }
}

