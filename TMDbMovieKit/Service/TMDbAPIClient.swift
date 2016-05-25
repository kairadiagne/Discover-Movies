//
//  TMDbAPIClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

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

class TMDbAPIClient {
    
    struct URL {
        static let Base = "https://api.themoviedb.org/3/"
        static let BaseImage = "https://image.tmdb.org/t/p/"
        static let Authenticate = "https://www.themoviedb.org/authenticate/"
        static let NewSession = "https://api.themoviedb.org/3/authentication/session/new/"
        static let Gravatar = "http://www.gravatar.com/avatar/"
    }

    var APIKey: String {
        return TMDbSessionInfoStore().APIKey
    }
    
    var sessionID: String? {
        return TMDbSessionInfoStore().sessionID
    }
    
    var userID: Int? {
        return TMDbSessionInfoStore().user?.userID
    }
    
}

public enum TMDbAccountList: String {
    case Favorites = "favorite"
    case Watchlist = "watchlist"
}

public enum TMDbToplist: String {
    case Popular = "popular"
    case TopRated = "top_rated"
    case Upcoming = "upcoming"
    case NowPlaying = "now_playing"
}

class TMDbMovieClient: TMDbAPIClient {
    
    typealias MovieListCompletionHandler = (Result<TMDbList<TMDbMovie>, NSError>) -> Void
    typealias MovieListResponse = (Response<TMDbList<TMDbMovie>, NSError>)
    typealias MovieInfoCompletionHandler = (Result<TMDbMovieInfo, NSError>) -> Void
    typealias MovieInfoResponse = (Response<TMDbMovieInfo, NSError>)
    typealias ReviewCompletionHandler = (Result<TMDbList<TMDbReview>, NSError>) -> Void
    typealias ReviewResponse = (Response<TMDbList<TMDbReview>, NSError>)
    
    
    // MARK: - Toplist
    
    func fetchToplist(list: TMDbToplist, page: Int, completionHandler: MovieListCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["page"] = page
        parameters["api_key"] = APIKey

        let url = URL.Base + "movie/\(list.rawValue)"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: MovieListResponse) in
                completionHandler(response.result)
        }
    }
    
    // MARK: - Search & Discover
    
    func discover(year: String?, genre: Int?, vote: Float?, page: Int, completionHandler: MovieListCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["primary_release_year"] = year ?? nil
        parameters["with_genres"] = genre ?? nil
        parameters["vote_average.gte"] = vote ?? nil
        parameters["page"] = page
        parameters["sort_by"] = "popularity.desc"
        parameters["api_key"] = APIKey
        
        let url =  URL.Base + "discover/movie"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: MovieListResponse) in
                completionHandler(response.result)
        }
    }

    func movieWithTitle(title: String, page: Int, completionHandler: MovieListCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["page"] = page
        parameters["api_key"] = APIKey
        
        let url = URL.Base + "search/movie"

        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: MovieListResponse) in
                completionHandler(response.result)
        }
    }
    
    // MARK: - Watchlist & Favorites
    
    func fetchAccountList(list: TMDbAccountList, page: Int, completionHandler: MovieListCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["page"] = page
        parameters["session_id"] = sessionID ?? ""
        parameters["api_key"] = APIKey
        
        let url = URL.Base + "account/\(userID)/\(list)/movies"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: MovieListResponse) in
                completionHandler(response.result)
        }
    }
    
    func accountStateForMovie(movieID: Int, completionHandler: Response<TMDbAccountState, NSError> -> Void) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["session_id"] = sessionID ?? ""
        parameters["api_key"] = APIKey
        
        let url = URL.Base + "movie/\(movieID)/account_states"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil)
            .responseObject { (response: Response<TMDbAccountState, NSError>) in
                completionHandler(response)
        }

    }

    // CHANGE ACCOUNT STATE
    
    // MARK: - Movie Info (Similar movies, credits, trailers)
    
    func fetchAdditionalInfoMovie(movieID: Int, completionHandler: MovieInfoCompletionHandler) {
    
        var parameters: [String: AnyObject] = [:]
        parameters["append_to_response"] = "similar,credits,trailers"
        parameters["api_key"] = APIKey
    
        let url = URL.Base + "movie/\(movieID)"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: MovieInfoResponse) in
                completionHandler(response.result)
        }
    }
    
    // MARK: - Reviews

    func fetchReviews(movieID: Int, page: Int?, completionHandler: ReviewCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["api_key"] = APIKey
        
        let url = URL.Base + "\(movieID)/reviews"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: ReviewResponse) in
                completionHandler(response.result)
        }
    }
    
}


class TMDbSignInClient: TMDbAPIClient {
    
    private var requestToken: TMDbRequestToken?
    
    // MARK: - Sign In 
    
    // Generates a valid request token for user based authentication
    func getRequestToken(completionHandler: (url: NSURL?, error: NSError?) -> Void) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["api_key"] = APIKey
        
        let url = URL.Base + "authentication/token/new"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: Response<TMDbRequestToken, NSError>) in
                
                guard response.result.error == nil else {
                    completionHandler(url: nil, error: response.result.error!)
                    return
                }
                
                if let requestToken = response.result.value {
                    self.requestToken = requestToken
                    let url = self.createAuthorizeURL(requestToken.token)
                    completionHandler(url: url, error: nil)
                }
        }
        
    }
    
    func requestSessionID(completionHandler: (sessionID: TMDbSessionID?, error: NSError?) -> Void) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["api_key"] = APIKey
        parameters["request_token"] = requestToken?.token ?? ""
        
        let url = URL.Base + "authentication/session/new"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: Response<TMDbSessionID, NSError>) in
                
                guard response.result.error == nil else {
                    completionHandler(sessionID: nil, error: response.result.error!)
                    return
                }
                
                if let sessionID = response.result.value {
                    completionHandler(sessionID: sessionID, error: nil)
                }
        }
        
    }
    
    private func createAuthorizeURL(requestToken: String) -> NSURL? {
        let path: String = "\(TMDbAPI.AuthenticateURL)\(requestToken)"
        let url = NSURL(string: path)
        return url
    }
    
}



    


    









