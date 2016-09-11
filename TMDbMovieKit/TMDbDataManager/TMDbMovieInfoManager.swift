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
    func movieInfoManagerDidReceiverError(_ error: APIError) // Did fail with error
}

public class TMDbMovieInfoManager { // Change open to public
    
    // MARK: - Properties
    
    public weak var delegate: TMDbMovieInfoManagerDelegate?
    
    public fileprivate(set) var movieID: Int
    
    fileprivate let utilityQueue = DispatchQueue.global(qos: .utility)
    
    fileprivate let errorHandler: ErrorHandling
    
    // MARK: - Initialization
    
    public init(movieID: Int) {
        self.errorHandler = APIErrorHandler()
        self.movieID = movieID
    }
    
    // MARK: - API Calls
    
    public func loadInfo() {
        let parameters: [String: AnyObject] = ["append_to_response": "similar,credits,trailers" as AnyObject]
        
        let endpoint = "movie/\(movieID)"
        
        Alamofire.request(APIRouter.get(endPoint: endpoint, queryParams: parameters)).validate()
            .responseObject(queue: utilityQueue) { (response: DataResponse<MovieInfo>) in
            
                guard response.result.error == nil else {
                    let error = self.errorHandler.categorize(error: response.result.error!)
                    self.delegate?.movieInfoManagerDidReceiverError(error)
                    return
                }
                
                if let movieInfo = response.result.value {
                    self.delegate?.movieInfomManagerDidLoadInfoForMovieWithID(self.movieID, info: movieInfo)
                }
        }
    }

    public func toggleStatusOfMovieInList(_ list: TMDbAccountList, status: Bool) {
        guard let sessionID = TMDbSessionInfoStore().sessionID, let userID = TMDbSessionInfoStore().user?.id else {
            delegate?.movieInfoManagerDidReceiverError(.notAuthorized)
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        let body: [String: AnyObject] = ["media_type": "movie" as AnyObject, "media_id": movieID as AnyObject, list.name: status as AnyObject]
        
        let endpoint = "account/\(userID)/\(list.name)"
        
        Alamofire.request(APIRouter.post(endPoint: endpoint, queryParams: parameters, bodyParams: body)).validate()
            .response { (response) in
                
                guard response.error == nil else {
                    let error = self.errorHandler.categorize(error: response.error!)
                    self.delegate?.movieInfoManagerDidReceiverError(error)
                    return
                }
        }
        
    }
    
    public func loadAccountState() {
        guard let sessionID = TMDbSessionInfoStore().sessionID else {
            delegate?.movieInfoManagerDidReceiverError(.notAuthorized)
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        let endpoint = "movie/\(movieID)/account_states"
        
        Alamofire.request(APIRouter.get(endPoint: endpoint, queryParams: parameters)).validate()
            .responseObject { (response: DataResponse<AccountState>) in
                
                guard response.result.error == nil else {
                    let error = self.errorHandler.categorize(error: response.result.error!)
                    self.delegate?.movieInfoManagerDidReceiverError(error)
                    return
                }
                
                if let accountState = response.result.value {
                    self.delegate?.movieInfoManagerDidLoadAccoutnStateForMovieWithID(self.movieID, inFavorites: accountState.favoriteStatus, inWatchList: accountState.watchlistStatus)
                }
        }

    }
    
}
