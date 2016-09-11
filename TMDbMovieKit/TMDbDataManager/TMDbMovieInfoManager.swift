//
//  TMDbMovieInfoManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public protocol TMDbMovieInfoManagerDelegate: class {
    func movieInfomManagerDidLoadInfoForMovieWithID(_ movieID: Int, info: MovieInfo)
    func movieInfoManagerDidLoadAccoutnStateForMovieWithID(_ movieID: Int, inFavorites: Bool, inWatchList: Bool)
    func movieInfoManagerDidReceiverError(_ error: APIError)
}

public class TMDbMovieInfoManager { // Change open to public
    
    // MARK: - Properties
    
    open weak var delegate: TMDbMovieInfoManagerDelegate?
    
    open fileprivate(set) var movieID: Int
    
    // MARK: - Initialization
    
    public init(movieID: Int) {
        self.movieID = movieID
    }
    
    // MARK: - API Calls
    
    open func loadInfo() {
        let parameters: [String: AnyObject] = ["append_to_response": "similar,credits,trailers" as AnyObject]
        
        let endpoint = "movie/\(movieID)"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<MovieInfo, NSError>) in
                
                guard response.result.error == nil else {
                    self.handleError(response.result.error!)
                    return
                }
                
                if let movieInfo = response.result.value {
                    self.delegate?.movieInfomManagerDidLoadInfoForMovieWithID(self.movieID, info: movieInfo)
                }
        }
    }

    open func toggleStatusOfMovieInList(_ list: TMDbAccountList, status: Bool) {
        guard let sessionID = TMDbSessionInfoStore().sessionID, let userID = TMDbSessionInfoStore().user?.id else {
            delegate?.movieInfoManagerDidReceiverError(.notAuthorized)
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        let body: [String: AnyObject] = ["media_type": "movie" as AnyObject, "media_id": movieID as AnyObject, list.name: status as AnyObject]
        
        let endpoint = "account/\(userID)/\(list.name)"
        
        Alamofire.request(TMDbAPIRouter.POST(endpoint: endpoint, parameters: parameters, body: body))
            .response { (request, response, data, error) in
                
                guard error == nil else {
                    self.handleError(error!)
                    return
                }
            
        }
    }
    
    open func loadAccountState() {
        guard let sessionID = TMDbSessionInfoStore().sessionID else {
            delegate?.movieInfoManagerDidReceiverError(.notAuthorized)
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        let endpoint = "movie/\(movieID)/account_states"
        
        Alamofire.request(TMDbAPIRouter.GET(endpoint: endpoint, parameters: parameters)).validate()
            .responseObject { (response: Response<AccountState, NSError>) in
                
                guard response.result.error == nil else {
                    self.handleError(response.result.error!)
                    return
                }
                
                if let accountState = response.result.value {
                    self.delegate?.movieInfoManagerDidLoadAccoutnStateForMovieWithID(self.movieID, inFavorites: accountState.favoriteStatus, inWatchList: accountState.watchlistStatus)
                }
        }

    }
    
    // MARK: - Handle Error
    
    func handleError(_ error: NSError) {
        var newError: APIError
        
        if error.code == NSURLErrorNotConnectedToInternet {
            newError = .noInternetConnection
        } else if error.code == NSURLErrorUserAuthenticationRequired {
            newError = .notAuthorized
        } else {
            newError = .generic
        }
        
        delegate?.movieInfoManagerDidReceiverError(newError)
    }
    
}
