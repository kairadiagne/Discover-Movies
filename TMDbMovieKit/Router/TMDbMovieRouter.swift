//
//  TMDbMovieRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

private struct Key {
    static let ReleaseYear = "primary_release_year"
    static let Genre = "with_genres"
    static let Vote = "vote_average.gte"
    static let Sort = "sort_by"
    static let Page = "page"
    static let SessionID = "session_id"
    static let MediaID = "media_id"
    static let MediaType = "media_type"
    static let Favorite = "favorite"
    static let WatchList = "watchlist"
    static let StatusCode = "status_code"
    static let Query = "query"
    static let APIKey = "api_key"
}

enum TMDbMovieRouter: URLRequestConvertible {
    case TopList(list: String, page: Int?, APIKey: String)
    case Discover(year: String?, genre: Int?, vote:Float?, page: Int?, APIKey: String)
    case SearchByTitle(title: String, page: Int?, APIKey: String)
    case List(list: String, sessionID: String, accountID: Int, page: Int?, APIKey: String)
    case SimilarMovies(id: Int, page: Int?, APIKey: String)
    case MovieCredits(movieID: Int, APIKey: String)
    case Reviews(movieID: Int, page: Int?, APIKey: String)
    case Videos(movieID: Int, APIKey: String)
    case AccountState(movieID: Int, sessionID: String, APIKey: String)
    case AddRemoveFromList(body: [String: AnyObject], accountID: Int, list: String, sessionID: String, APIKey: String)
    
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
            case .MovieCredits:
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
        
            var parameters = [String: AnyObject]()
        
            switch self {
            case .TopList(let list, let page, let APIKey):
                if let page = page { parameters[Key.Page] = page }
                parameters[Key.APIKey] = APIKey
                return ("movie/\(list)", parameters)
            case .Discover(let year, let genre, let voteAverage, let page, let APIKey):
                if let year = year { parameters[Key.ReleaseYear] = year }
                if let genre = genre { parameters[Key.Genre] = genre }
                if let voteAverage = voteAverage { parameters[Key.Vote] = voteAverage }
                if let page = page { parameters[Key.Page] = page }
                parameters[Key.Sort] = "popularity.desc"
                parameters[Key.APIKey] = APIKey
                return ("discover/movie", parameters)
            case .SearchByTitle(let title, let page, let APIKey):
                parameters[Key.Query] = title
                if let page = page { parameters[Key.Page] = page }
                parameters[Key.APIKey] = APIKey
                return ("search/movie", parameters)
            case .List(let list, let sessionID, let accountID, let page, let APIKey):
                parameters[Key.SessionID] = sessionID
                if let page = page { parameters[Key.Page] = page }
                parameters[Key.APIKey] = APIKey
                return ("account/\(accountID)/\(list)/movies", parameters)
            case .SimilarMovies(let movieID, let page, let APIKey):
                if let page = page { parameters[Key.Page] = page }
                parameters[Key.APIKey] = APIKey
                return ("movie/\(movieID)/similar", parameters)
            case .MovieCredits(let movieID, let APIKey):
                parameters[Key.APIKey] = APIKey
                return ("movie/\(movieID)/credits", parameters)
            case .Reviews(let movieID, let page, let APIKey):
                if let page = page { parameters[Key.Page] = page }
                parameters[Key.APIKey] = APIKey
                return ("movie/\(movieID)/reviews", parameters)
            case .Videos(let movieID, let APIKey):
                parameters[Key.APIKey] = APIKey
                return ("movie/\(movieID)/videos", parameters)
            case .AccountState(let movieID, let sessionID, let APIKey):
                parameters[Key.SessionID] = sessionID
                parameters[Key.APIKey] = APIKey
                return ("movie/\(movieID)/account_states", parameters)
            case .AddRemoveFromList(_, let accountID, let list, let sessionID, let APIKey):
                parameters[Key.SessionID] = sessionID
                parameters[Key.APIKey] = APIKey
                return("account/\(accountID)/\(list)", parameters)
            }
        }()
        
        
        let body: [String: AnyObject]? = {
            switch self {
            case .AddRemoveFromList(let body, _, _, _, _): return body
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

