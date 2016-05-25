////
////  TMDbMovieService.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 13-04-16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import Foundation
//import Alamofire
//import AlamofireObjectMapper
//
//struct Constants {
//    static let APIKey = "api_key"
//    static let BaseURL = "https://api.themoviedb.org/3/"
//}
//
//// Remove later
//import SwiftyJSON
//
//// TODO: - Almofire requets with completiohandler that returns on the main thread
//
//// Completionhandlers
////typealias TMDbReviewCompletionHandler = (result: TMDbListHolder<TMDbReview>?, error: NSError?) -> ()
////typealias TMDbVideosCompletionHandler = (result: [TMDbVideo]?, error: NSError?) -> ()
////typealias TMDbAccountStateCompletionHandler = (inFavorites: Bool?, inWatchList: Bool?, error: NSError?) -> ()
////typealias TMDbChangeAccountStateCompletionHandler = (success: Bool, error: NSError?) -> ()
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//class TMDbMovieService {
//    
//   
//    
//    
//    
//    
//    
//    
//    
//    
//
//    
//    
//    
//
//    
//  
//    
//    
//    
//    
//    // Get the similar movies for a specific movie id.
// 
//    
//    
//    // MARK: - Fetch Additional info About Movie
//    
//    
//    // Get the videos (trailers, teasers, clips, etc...) for a specific movie id.
//    
//    func fetchVideosForMovie(movieID: Int, completionHandler: TMDbVideosCompletionHandler) {
//        Alamofire.request(TMDbMovieRouter.Videos(movieID: movieID, APIKey: APIKey)).validate().responseArray("results") { (response) in
//            completionHandler(result: response.result.value, error: response.result.error)
//        }
//    }
//    
//    func fetchReviews(movieID: Int, page: Int?, completionHandler: TMDbReviewCompletionHandler) {
//        Alamofire.request(TMDbMovieRouter.Reviews(movieID: movieID, page: page, APIKey: APIKey)).validate().responseResult { (response) in
//            completionHandler(result: response.result.value, error: response.result.error)
//        }
//    }
//    
//    // Get the cast and crew information for a specific movie id.
//    
//    func fetchCreditsForMovie(withID id: Int, completionHandler: (credit: TMDbMovieCredit?, error: NSError?) -> ()) {
//        Alamofire.request(TMDbMovieRouter.MovieCredits(movieID: id, APIKey: APIKey)).validate().responseObject {
//            (response: Response<TMDbMovieCredit, NSError>) in
//            completionHandler(credit: response.result.value, error: response.result.error)
//        }
//    }
//    
//    // MARK: - Calls that require user authentication
//    
//    /*  Steps to take when making a call that requires user authentication
//        1. First check if the user is signed in and retrieve the session ID
//        2. If the call requires the userID then retrieve this as well
//        3. Make the request (If our sessionID is not valid anymore we get back an authorization errro)
//     */
//    
//    /* Fetches lists for an account:
//     - Get the list of favorite movies for an account.
//     - Get the list of movies on an accounts watchlist
//    */
//    
//    func fetchMoviesInList(list: String, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
//        guard let sessionID = sessionID else { return completionHandler(result: nil, error: authorizationError) }
//        guard let userID = userID else { return completionHandler(result: nil, error: authorizationError) }
//        
//        Alamofire.request(TMDbMovieRouter.List(list: list, sessionID: sessionID, accountID: userID, page: page, APIKey: APIKey)).validate().responseResult {
//            (response: Response<TMDbListHolder<TMDbMovie>, NSError>) in
//            if let response = response.response, unauthorizedError = self.checkResponseForAuthorizationError(response) {
//                completionHandler(result: nil, error: unauthorizedError)
//            }
//            completionHandler(result: response.result.value, error: nil)
//        }
//    }
//    
//    // Lets the users get the status of wether or not the TV show has been rated or added to their favourite or watch list.
//    
//    func accountStateForMovie(movieID: Int, completionHandler: TMDbAccountStateCompletionHandler ) {
//        guard let sessionID = sessionID else { return completionHandler(inFavorites: nil, inWatchList: nil, error: authorizationError) }
//        
//        Alamofire.request(TMDbMovieRouter.AccountState(movieID: movieID, sessionID: sessionID, APIKey: APIKey)).validate().responseJSON { (response) in
//            if let response = response.response, unauthorizedError = self.checkResponseForAuthorizationError(response) {
//                completionHandler(inFavorites: nil, inWatchList: nil, error: unauthorizedError)
//            }
//            if let inFavorites = response.result.value?["favorite"] as? Bool, inWatchList = response.result.value?["watchlist"] as? Bool {
//                completionHandler(inFavorites: inFavorites, inWatchList: inWatchList, error: nil )
//            }
//        }
//    }
//    
//    // Add or remove a movie to an accounts favorite list or watchlist
//
//    func changeAccountStateForMovie(withID movieID: Int, inList list: String, toStatus status: Bool, completionHandler: TMDbChangeAccountStateCompletionHandler) {
//        guard let sessionID = sessionID else { return completionHandler(success: false, error: authorizationError) }
//        guard let userID = userID else { return completionHandler(success: false, error: authorizationError) }
//        
//        let JSONBody: [String: AnyObject] = ["media_id": movieID, "media_type": "movie", list : status]
//        
//        Alamofire.request(TMDbMovieRouter.AddRemoveFromList(body: JSONBody, accountID: userID, list: list, sessionID: sessionID, APIKey: APIKey)).validate().responseJSON { (response) in
//            if let response = response.response, unauthorizedError = self.checkResponseForAuthorizationError(response) {
//                completionHandler(success: false, error: unauthorizedError)
//            }
//            
//            if let error = response.result.error {
//                completionHandler(success: false, error: error)
//            }
//            
//            completionHandler(success: true, error: nil)
//        }
//    }
//    
//    // MARK: - Helpers
//    
//    // TODO: - Advanced Error handeling (InternetConnection Error, Authorization error, 
//    
//    private func checkResponseForAuthorizationError(urlResponse: NSHTTPURLResponse) -> NSError? {
//        guard urlResponse.statusCode == 401 else { return nil }
//        return authorizationError
//    }
//    
//    private var authorizationError: NSError {
//        let userInfo = [NSLocalizedDescriptionKey: "Not Logged In", NSLocalizedRecoverySuggestionErrorKey: "Please re-enter your TMDb credentials"]
//        let unauthorizedError = NSError(domain: NSURLErrorDomain, code: NSURLErrorUserAuthenticationRequired, userInfo: userInfo)
//        return unauthorizedError
//    }
//    
//}
