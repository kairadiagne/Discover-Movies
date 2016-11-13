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
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didLoadInfo info: MovieInfo, forMovieWIthID id: Int)
    func movieInfoManager(_ manager: TMDbMovieInfoManager, movieWithID: Int, inFavorites: Bool, inWatchList: Bool)
    func movieInfoManager(_ manager: TMDbMovieInfoManager, didFailWithErorr error: APIError)
}

public class TMDbMovieInfoManager {
    
    // MARK: - Properties
    
    public weak var delegate: TMDbMovieInfoManagerDelegate?
    
    public let movieID: Int
    
    fileprivate let errorHandler: ErrorHandling
    
    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.errorHandler = APIErrorHandler()
        self.movieID = movieID
    }
    
    // MARK: - API Calls
    
    public func loadInfo() {
        let parameters: [String: AnyObject] = ["append_to_response": "credits,trailers" as AnyObject]
        
        let endpoint = "movie/\(movieID)"
        
        Alamofire.request(APIRouter.get(endpoint: endpoint, queryParams: parameters)).validate()
            .responseObject { (response: DataResponse<MovieInfo>) in
                
                switch response.result {
                case .success(let data):
                    self.delegate?.movieInfoManager(self, didLoadInfo: data, forMovieWIthID: self.movieID)
                case .failure(let error):
                    let error = self.errorHandler.categorize(error: error)
                    self.delegate?.movieInfoManager(self, didFailWithErorr: error)
                }
            
        }
    }

    public func toggleStatusOfMovieInList(_ list: TMDbAccountList, status: Bool) {
        guard let sessionID = TMDbSessionInfoStore().sessionID, let userID = TMDbSessionInfoStore().user?.id else {
            delegate?.movieInfoManager(self, didFailWithErorr: .unAuthorized)
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        let body: [String: AnyObject] = ["media_type": "movie" as AnyObject, "media_id": movieID as AnyObject, list.name: status as AnyObject]
        
        let endpoint = "account/\(userID)/\(list.name)"
        
        Alamofire.request(APIRouter.post(endpoint: endpoint, queryParams: parameters, bodyParams: body)).validate()
            .responseJSON { (response) in
                
                guard response.result.error == nil else {
                    let error = self.errorHandler.categorize(error: response.result.error!)
                    self.delegate?.movieInfoManager(self, didFailWithErorr: error)
                    return
                }
            
        }
        
    }

    
    public func loadAccountState() {
        guard let sessionID = TMDbSessionInfoStore().sessionID else {
            delegate?.movieInfoManager(self, didFailWithErorr: .unAuthorized)
            return
        }
        
        let parameters: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        let endpoint = "movie/\(movieID)/account_states"
        
        Alamofire.request(APIRouter.get(endpoint: endpoint, queryParams: parameters)).validate()
            .responseObject { (response: DataResponse<AccountState>) in
                
                switch response.result {
                case .success(let data):
                    self.delegate?.movieInfoManager(self, movieWithID: self.movieID, inFavorites: data.favoriteStatus, inWatchList: data.watchlistStatus)
                case .failure(let error):
                    let error = self.errorHandler.categorize(error: error)
                    self.delegate?.movieInfoManager(self, didFailWithErorr: error)
                }
        }

    }
    
}
