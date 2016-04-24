//
//  TMDbMovieService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Completionhandlers
public typealias TMDbMovieCompletionHandler = (result: TMDbFetchResult<TMDbMovie>?, error: NSError?) -> ()
public typealias TMDbReviewCompletionHandler = (result: TMDbFetchResult<TMDbReview>?, error: NSError?) -> ()
public typealias TMDbVideosCompletionHandler = (result: [TMDbVideo]?, error: NSError?) -> ()
public typealias TMDbAccountStateCompletionHandler = (inFavorites: Bool?, inWatchList: Bool?, error: NSError?) -> ()
public typealias TMDbChangeAccountStateCompletionHandler = (success: Bool, error: NSError?) -> ()

public class TMDbMovieService {
    
    private let APIKey: String
    private let userInfoStore: TMDbUserInfoStore
    
    public init(APIKey key: String) {
        self.APIKey = key
        self.userInfoStore = TMDbUserInfoStore()
    }
   
    // MARK: - Fetch Lists of Movies

    /*
     Fetch a TMDb Toplist (refresh evrery day):
     - Popular: Get the list of popular movies on the Movie Databse.
     - Top rated: Get the list of top rated movies. by default this list will onlu include movies that have 50 or more votes.
     - Upcoming: Get the list of upcoming movies by release date. This list refreshes every day. 
     - Now playing: get the list of movies playing that have been, or are being released this week.
     
    */
    
    public func fetchTopList(list: String, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.TopList(list: list, page: page, APIKey: APIKey)).validate().responseResult { (response) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    /* 
     Discover movies by different types of data like average rating, year of release and genre.
     The group of movies that comes back as a response is sorted by popularity rating (Ascending)
    */
    
    public func discoverMovies(year: String?, genre: Int?, vote: Float?, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.Discover(year: year, genre: genre, vote: vote, page: page, APIKey: APIKey)).validate().responseResult { (response) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    
    // Search for movies by title.
 
    
    public func searchForMovieWith(title: String, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.SearchByTitle(title: title, page: page, APIKey: APIKey)).validate().responseResult { (response) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    // Get the similar movies for a specific movie id.
 
    public func fetchMoviesSimilarToMovie(withID id: Int, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.SimilarMovies(id: id, page: page, APIKey: APIKey)).validate().responseResult { (response) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    // MARK: - Fetch Additional info About Movie
    
    
    // Get the videos (trailers, teasers, clips, etc...) for a specific movie id.
    
    public func fetchVideosForMovie(movieID: Int, completionHandler: TMDbVideosCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.Videos(movieID: movieID, APIKey: APIKey)).validate().responseArray("results") { (response) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    public func fetchReviews(movieID: Int, page: Int?, completionHandler: TMDbReviewCompletionHandler) {
        Alamofire.request(TMDbMovieRouter.Reviews(movieID: movieID, page: page, APIKey: APIKey)).validate().responseResult { (response) in
            completionHandler(result: response.result.value, error: response.result.error)
        }
    }
    
    // MARK: - Calls that require user authentication
    
    /*  Steps to take when making a call that requires user authentication
        1. First check if the user is signed in and retrieve the session ID
        2. If the call requires the userID then retrieve this as well
        3. Make the request (If our sessionID is not valid anymore we get back an authorization errro)
     */
    
    /* Fetches lists for an account:
     - Get the list of favorite movies for an account.
     - Get the list of movies on an accounts watchlist
    */
    
    public func fetchMoviesInList(list: String, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        guard userInfoStore.userStatus == .Signedin else { return completionHandler(result: nil, error: authorizationError) }
        guard let sessionID = userInfoStore.sessionID else { return completionHandler(result: nil, error: authorizationError) }
        guard let userID = userInfoStore.user?.userID else { return completionHandler(result: nil, error: authorizationError) }
        
        Alamofire.request(TMDbMovieRouter.List(list: list, sessionID: sessionID, accountID: userID, page: page, APIKey: APIKey)).validate().responseResult {
            (response: Response<TMDbFetchResult<TMDbMovie>, NSError>) in
            if let response = response.response, unauthorizedError = self.checkResponseForAuthorizationError(response) {
                completionHandler(result: nil, error: unauthorizedError)
            }
            completionHandler(result: response.result.value, error: nil)
        }
    }
    
    // Lets the users get the status of wether or not the TV show has been rated or added to their favourite or watch list.
    
    public func accountStateForMovie(movieID: Int, completionHandler: TMDbAccountStateCompletionHandler ) {
        guard userInfoStore.userStatus == .Signedin else { return completionHandler(inFavorites: nil, inWatchList: nil, error: authorizationError) }
        guard let sessionID = userInfoStore.sessionID else { return completionHandler(inFavorites: nil, inWatchList: nil, error: authorizationError) }
        
        Alamofire.request(TMDbMovieRouter.AccountState(movieID: movieID, sessionID: sessionID, APIKey: APIKey)).validate().responseJSON { (response) in
            if let response = response.response, unauthorizedError = self.checkResponseForAuthorizationError(response) {
                completionHandler(inFavorites: nil, inWatchList: nil, error: unauthorizedError)
            }
            if let inFavorites = response.result.value?["favorite"] as? Bool, inWatchList = response.result.value?["watchlist"] as? Bool {
                completionHandler(inFavorites: inFavorites, inWatchList: inWatchList, error: nil )
            }
        }
    }
    
    // Add or remove a movie to an accounts favorite list or watchlist
    
    public func changeAccountStateForMovie(withID movieID: Int, inList list: String, toStatus status: Bool, completionHandler: TMDbChangeAccountStateCompletionHandler) {
        guard userInfoStore.userStatus == .Signedin else { return completionHandler(success: false, error: authorizationError) }
        guard let sessionID = userInfoStore.sessionID else { return completionHandler(success: false, error: authorizationError) }
        guard let userID = userInfoStore.user?.userID else { return completionHandler(success: false, error: authorizationError) }
        
        let JSONBody: [String: AnyObject] = ["media_id": movieID, "media_type": "movie", list : status]
        
        Alamofire.request(TMDbMovieRouter.AddRemoveFromList(body: JSONBody, accountID: userID, list: list, sessionID: sessionID, APIKey: APIKey)).validate().responseJSON { (response) in
            if let response = response.response, unauthorizedError = self.checkResponseForAuthorizationError(response) {
                completionHandler(success: false, error: unauthorizedError)
            }
            
            if let error = response.result.error {
                completionHandler(success: false, error: error)
            }
            
            completionHandler(success: true, error: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func checkResponseForAuthorizationError(urlResponse: NSHTTPURLResponse) -> NSError? {
        guard urlResponse.statusCode == 401 else { return nil }
        return authorizationError
    }
    
    private var authorizationError: NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Not Logged In", NSLocalizedRecoverySuggestionErrorKey: "Please re-enter your TMDb credentials"]
        let unauthorizedError = NSError(domain: NSURLErrorDomain, code: NSURLErrorUserAuthenticationRequired, userInfo: userInfo)
        return unauthorizedError
    }
    
}
