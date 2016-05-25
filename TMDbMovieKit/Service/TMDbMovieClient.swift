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
    
    typealias MovieListCompletionHandler = (Result<TMDbList<TMDbMovie>, NSError>) -> Void
    
    typealias MovieListResponse = (Response<TMDbList<TMDbMovie>, NSError>)

    // Fetches themoviedb toplist (Popular, Toprated, Upcoming, Now playing)
    
    func fetchToplist(list: TMDbToplist, page: Int, completionHandler: MovieListCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["page"] = page

        let endpoint = "movie/\(list.rawValue)"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: MovieListResponse) in
                
                completionHandler(response.result)
        }
    }
    
    // Searches for movies by year, genre, vote and sorts the results based on popularity rating (Asscending)
    
    func discover(year: String?, genre: Int?, vote: Float?, page: Int, completionHandler: MovieListCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["primary_release_year"] = year ?? nil // Remove nil coloascing??
        parameters["with_genres"] = genre ?? nil // Remove nil coloascing??
        parameters["vote_average.gte"] = vote ?? nil // Remove nil coloascing??
        parameters["page"] = page
        parameters["sort_by"] = "popularity.desc"
        
        let endpoint =  "discover/movie"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: MovieListResponse) in
                
                completionHandler(response.result)
        }
    }
    
    // Search for movies by title
    
    func movieWithTitle(title: String, page: Int, completionHandler: MovieListCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["page"] = page
        
        let endpoint = URL.Base + "search/movie"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: MovieListResponse) in
                
                completionHandler(response.result)
        }
    }
    
    // Checks if a movie belongs to the watchlist and/or favorites list
    
    func fetchAccountList(list: TMDbAccountList, page: Int, completionHandler: MovieListCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["page"] = page
        parameters["session_id"] = sessionID ?? "" // Remove "" coloascing??
        
        let endpoint = "account/\(userID)/\(list)/movies"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: MovieListResponse) in
                
                completionHandler(response.result)
        }
    }
    
    // Changes the status of a movie in the watchlist or favorites list
    
    func accountStateForMovie(movieID: Int, completionHandler: Result<TMDbAccountState, NSError> -> Void) {

        var parameters: [String: AnyObject] = [:]
        parameters["session_id"] = sessionID ?? ""
        
        let endpoint = "movie/\(movieID)/account_states"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbAccountState, NSError>) in
    
                completionHandler(response.result)
        }
    }
    
    func changeStateForMovie(movieID: Int, inList: String, toState state: Bool, completionHandler: (error: NSError?) -> Void) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["session_id"] = sessionID
        
        let accountID = 0
        let list = ""

        let endpoint = "account/\(accountID)/\(list)"
    
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .response { (request, response, data, error) in
                
                guard error == nil else {
                    completionHandler(error: error)
                    return
                }
                
                completionHandler(error: nil)
        }
        
    }
    
   // MARK: - Additional Movie Info
    
    typealias MovieInfoCompletionHandler = (Result<TMDbMovieInfo, NSError>) -> Void
    
    // Fetches additional info about a movie (Similar movies, movie credits,  trailers)
    
    func fetchAdditionalInfoMovie(movieID: Int, completionHandler: MovieInfoCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["append_to_response"] = "similar,credits,trailers"
        
        let endpoint = "movie/\(movieID)"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<TMDbMovieInfo, NSError>) in
                
                completionHandler(response.result)
        }
    }
    
    // MARK: - Reviews
    
    typealias ReviewCompletionHandler = (Result<TMDbList<TMDbReview>, NSError>) -> Void
    
    // Fetches reviews about a specific movie
    
    func fetchReviews(movieID: Int, page: Int?, completionHandler: ReviewCompletionHandler) {
        
        var parameters: [String: AnyObject] = [:]
        parameters["api_key"] = APIKey
        
        let url = URL.Base + "\(movieID)/reviews"
        
        Alamofire.request(.GET, url, parameters: parameters, encoding: .URLEncodedInURL, headers: nil).validate()
            .responseObject { (response: Response<TMDbList<TMDbReview>, NSError>) in
                
                completionHandler(response.result)
        }
    }
    
}


