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
    func movieInfomManagerDidLoadInfoForMovieWithID(movieID: Int, info: MovieInfo)
    func movieInfoManagerDidLoadAccoutnStateForMovieWithID(movieID: Int, inFavorites: Bool, inWatchList: Bool)
    func movieInfoManagerDidReceiverError(error: TMDbAPIError)
}

public class TMDbMovieInfoManager {
    
    // MARK: - Properties
    
    public weak var delegate: TMDbMovieInfoManagerDelegate?
    
    public private(set) var movieID: Int
    
    // MARK: - Initialization
    
    public init(movieID: Int) {
        self.movieID = movieID
    }
    
    // MARK: - API Calls
    
    public func loadInfo() {
        let parameters: [String: AnyObject] = ["append_to_response": "similar,credits,trailers"]
        
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

    public func toggleStatusOfMovieInList(list: TMDbAccountList, status: Bool) {
        guard let sessionID = TMDbSessionInfoStore().sessionID, userID = TMDbSessionInfoStore().user?.id else {
            delegate?.movieInfoManagerDidReceiverError(TMDbAPIError.NotAuthorized)
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID]
        
        let body: [String: AnyObject] = ["media_type": "movie", "media_id": movieID, list.name: status]
        
        let endpoint = "account/\(userID)/\(list.name)"
        
        Alamofire.request(TMDbAPIRouter.POST(endpoint: endpoint, parameters: parameters, body: body))
            .response { (request, response, data, error) in
                
                guard error == nil else {
                    self.handleError(error!)
                    return
                }
            
        }
    }
    
    public func loadAccountState() {
        guard let sessionID = TMDbSessionInfoStore().sessionID else {
            delegate?.movieInfoManagerDidReceiverError(TMDbAPIError.NotAuthorized)
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID]
        
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
    
    func handleError(error: NSError) {
        var newError: TMDbAPIError
        
        if error.code == NSURLErrorNotConnectedToInternet {
            newError = .NoInternetConnection
        } else if error.code == NSURLErrorUserAuthenticationRequired {
            newError = .NotAuthorized
        } else {
            newError = .Generic
        }
        
        delegate?.movieInfoManagerDidReceiverError(newError)
    }
    
}
