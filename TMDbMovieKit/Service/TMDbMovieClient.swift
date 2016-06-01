//
//  TMDbMovieClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

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
    
    // MARK: - Fetching

    // Fetches themoviedb toplist (Popular, Toprated, Upcoming, Now playing)
    
    func fetchToplist(list: TMDbToplist, page: Int, completionHandler: (Result<TMDbList<TMDbMovie>, NSError>) -> Void) {
        let parameters: [String: AnyObject] = ["page": page]
        
        let endpoint = "movie/\(list.rawValue)"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbMovie>, NSError>) in
                completionHandler(response.result)
        }
    }
    
    // Searches for movies by year, genre, vote and sorts the results based on popularity rating (Asscending)
    
    func discover(year: String?, genre: Int?, vote: Float?, page: Int, completionHandler: (Result<TMDbList<TMDbMovie>, NSError>) -> Void) {
        var parameters: [String: AnyObject] = [:]
        parameters["primary_release_year"] = year
        parameters["with_genres"] = genre
        parameters["vote_average.gte"] = vote
        parameters["page"] = page
        parameters["sort_by"] = "popularity.desc"
        
        let endpoint =  "discover/movie"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbMovie>, NSError>) in
                completionHandler(response.result)
        }
    }
    
    // Search for movies by title
    
    func movieWithTitle(title: String, page: Int, completionHandler: (Result<TMDbList<TMDbMovie>, NSError>) -> Void) {
        let parameters: [String: AnyObject] = ["page": page, "query": title]
    
        let endpoint = "search/movie"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbMovie>, NSError>) in
                completionHandler(response.result)
        }
    }
    
    // Fetches the favorites list or the watchlist
    
    func fetchAccountList(list: TMDbAccountList, page: Int, completionHandler: (Result<TMDbList<TMDbMovie>, NSError>) -> Void) {
        guard let sessionID = sessionID , userID = userID else {
            // Return error
            return
        }
        
        let parameters: [String: AnyObject] = ["page": page, "session_id": sessionID]
        
        let endpoint = "account/\(userID)/\(list)/movies"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbMovie>, NSError>) in
                completionHandler(response.result)
        }
    }
    
    // Checks wether the movie is in the watchlsit and/or favorite list
    
    func accountStateForMovie(movieID: Int, completionHandler: Result<TMDbAccountState, NSError> -> Void) {
        guard let sessionID = sessionID else {
            // Return error 
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID]
        
        let endpoint = "movie/\(movieID)/account_states"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbAccountState, NSError>) in
                completionHandler(response.result)
        }
    }
    
    // Adds or removes a movie from the watchlist or favoritelist
    
    func changeStateForMovie(movieID: Int, inList: String, toState state: Bool, completionHandler: (error: NSError?) -> Void) {
        guard let sessionID = sessionID, userID = userID else {
            // Return error
            return
        }
    
        let parameters: [String: AnyObject] = ["session_id": sessionID]
        
        let list = ""
        
        let endpoint = "account/\(userID)/\(list)"
    
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate() // POST
            .response { (request, response, data, error) in
                
                guard error == nil else {
                    completionHandler(error: error)
                    return
                }
    
                completionHandler(error: nil)
        }
        
    }
    
    // Fetches additional info about a movie (Similar movies, movie credits,  trailers)
    
    func fetchAdditionalInfoMovie(movieID: Int, completionHandler: (Result<TMDbMovieInfo, NSError>) -> Void) {
        let parameters: [String: AnyObject] = ["append_to_response": "similar,credits,trailers"]
        
        let endpoint = "movie/\(movieID)"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbMovieInfo, NSError>) in
                completionHandler(response.result)
        }
    }
    
    // Fetches reviews about a specific movie
    
    func fetchReviews(movieID: Int, page: Int?, completionHandler: (Result<TMDbList<TMDbReview>, NSError>) -> Void) {
        let parameters: [String: AnyObject] = [:]
    
        let endpoint = "movie/\(movieID)/reviews"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbReview>, NSError>) in
              completionHandler(response.result)
        }
    }
    
}
