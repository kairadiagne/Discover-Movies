//
//  TMDbMovieClient.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

class TMDbMovieClient: TMDbAPIClient {

    // Fetches themoviedb toplist (Popular, Toprated, Upcoming, Now playing)
    
    func fetchToplist(list: TMDbToplist, page: Int, completionHandler: (list: TMDbList<TMDbMovie>?, error: NSError?) -> Void) {
        let parameters: [String: AnyObject] = ["page": page]
        
        let endpoint = "movie/\(list.rawValue)"
    
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbMovie>, NSError>) in
                completionHandler(list: response.result.value, error: response.result.error)
        }
    }
    
    // Searches for movies by year, genre, vote and sorts the results based on popularity rating (Asscending)
    
    func discover(year: String?, genre: Int?, vote: Float?, page: Int, completionHandler: (list: TMDbList<TMDbMovie>?, error: NSError?) -> Void) {
        var parameters: [String: AnyObject] = [:]
        parameters["primary_release_year"] = year
        parameters["with_genres"] = genre
        parameters["vote_average.gte"] = vote
        parameters["page"] = page
        parameters["sort_by"] = "popularity.desc"
        
        let endpoint =  "discover/movie"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbMovie>, NSError>) in
                completionHandler(list: response.result.value, error: response.result.error)
        }
    }
    
    // Search for movies by title
    
    func movieWithTitle(title: String, page: Int, completionHandler: (list: TMDbList<TMDbMovie>?, error: NSError?) -> Void) {
        let parameters: [String: AnyObject] = ["page": page, "query": title]
    
        let endpoint = "search/movie"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbMovie>, NSError>) in
                completionHandler(list: response.result.value, error: response.result.error)
        }
    }
    
    // Fetches the favorites list or the watchlist
    
    func fetchAccountList(list: TMDbAccountList, page: Int, completionHandler: (list: TMDbList<TMDbMovie>?, error: NSError?) -> Void) {
        guard let sessionID = sessionID , userID = userID else {
            return completionHandler(list: nil, error: authorizationError)
        }
        
        let parameters: [String: AnyObject] = ["page": page, "session_id": sessionID]
        
        let endpoint = "account/\(userID)/\(list.rawValue)/movies"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbMovie>, NSError>) in
                completionHandler(list: response.result.value, error: nil)
        }
    }
    
    // Checks wether the movie is in the watchlsit and/or favorite list
    
    func accountStateForMovie(movieID: Int, completionHandler: (state: TMDbAccountState?, error: NSError?) -> Void) {
        guard let sessionID = sessionID else {
            return completionHandler(state: nil, error: authorizationError)
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID]
        
        let endpoint = "movie/\(movieID)/account_states"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbAccountState, NSError>) in
                completionHandler(state: response.result.value, error: nil)
        }
    }
    
    // Adds or removes a movie from the watchlist or favoritelist
    
    func changeStateForMovie(movieID: Int, inList list: String, toState state: Bool, completionHandler: (error: NSError?) -> Void) {
        guard let sessionID = sessionID, userID = userID else {
            return completionHandler(error: authorizationError)
        }
    
        let parameters: [String: AnyObject] = ["session_id": sessionID]
        
        let body: [String: AnyObject] = ["media_type": "movie", "media_id": movieID, list: state]
        
        let endpoint = "account/\(userID)/\(list)"
    
        Alamofire.request(TMDbAPIRouter.POST(endpoint: endpoint, parameters: parameters, body: body))
            .response { (request, response, data, error) in
                
                guard error == nil else {
                    print(error)
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
    
    func fetchReviews(movieID: Int, page: Int?, completionHandler: (list: TMDbList<TMDbReview>?, error: NSError?) -> Void) {
        let parameters: [String: AnyObject] = [:]
    
        let endpoint = "movie/\(movieID)/reviews"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbList<TMDbReview>, NSError>) in
              completionHandler(list: response.result.value, error: response.result.error)
        }
    }
    
}
