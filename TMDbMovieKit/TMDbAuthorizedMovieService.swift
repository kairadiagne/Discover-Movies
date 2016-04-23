//
//  TMDbAuthorizedMovieService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class TMDbAuthorizedMovieService {
    
    private var userStore: TMDbUserStore!
    
    public init() {
        self.userStore = TMDbUserStore()
    }
    
    // MARK: - Fetch Lists
    
    public func fetchMoviesInList(list: String, page: Int?, completionHandler: TMDbMovieCompletionHandler) {
        // Check if user is signed otherwise we return an error
        guard userStore.userIsSignedIn == true else { return completionHandler(result: nil, error: authorizationError) }
        guard let sessionID = userStore.sessionID else { return completionHandler(result: nil, error: authorizationError) }
        guard let userID = userStore.user?.userID else { return completionHandler(result: nil, error: authorizationError) }
        
        // Make the request, will return authorization error if sessionID is not valid anymore
        Alamofire.request(TMDbMovieRouter.List(list, sessionID, userID, page)).validate().responseResult { (response: MovieResponse) in
            if let response = response.response, unauthorizedError = self.checkResponseForAuthorizationError(response) {
                completionHandler(result: nil, error: unauthorizedError)
            }
            completionHandler(result: response.result.value, error: nil)
        }
    }
    
    // MARK: - Account State
    
    public func accountStateForMovie(movieID: Int, completionHandler: (inFavorites: Bool?, inWatchList: Bool?, error: NSError?) -> ()) {
        // Check if user is signed otherwise we return an error
        guard userStore.userIsSignedIn == true else { return completionHandler(inFavorites: nil, inWatchList: nil, error: authorizationError) }
        guard let sessionID = userStore.sessionID else { return completionHandler(inFavorites: nil, inWatchList: nil, error: authorizationError) }
        
        // Make the request, will return authorization error if sessionID is not valid anymore
        Alamofire.request(TMDbMovieRouter.AccountState(movieID, sessionID)).validate().responseJSON { (response) in
            if let response = response.response, unauthorizedError = self.checkResponseForAuthorizationError(response) {
                completionHandler(inFavorites: nil, inWatchList: nil, error: unauthorizedError)
            }
            if let inFavorites = response.result.value?["favorite"] as? Bool, inWatchList = response.result.value?["watchlist"] as? Bool {
               completionHandler(inFavorites: inFavorites, inWatchList: inWatchList, error: nil )
            }
        }
    }
    
    public func changeAccountStateForMovie(withID movieID: Int, inList list: String, toStatus status: Bool, completionHandler: (success: Bool, error: NSError?) -> ()) {
        // Check if user is signed otherwise we return an error
        guard userStore.userIsSignedIn == true else { return completionHandler(success: false, error: authorizationError) }
        guard let sessionID = userStore.sessionID else { return completionHandler(success: false, error: authorizationError) }
        
        // Create jsonBody 
        let body: [String: AnyObject] = ["media_id": movieID, "media_type": "movie", list : status]
        
        // Make the request, will return authorization error if sessionID is not valid anymore
        Alamofire.request(TMDbMovieRouter.AddRemoveFromList(body, movieID, list, sessionID)).validate().responseJSON { (response) in
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
