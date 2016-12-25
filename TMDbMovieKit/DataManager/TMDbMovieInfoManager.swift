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
    
    private let sessionInfoProvider: SessionInfoContaining
    
    // MARK: - Initialize
    
    public convenience init(movieID: Int) {
        self.init(movieID: movieID, sessionInfoProvider: TMDbSessionInfoStore())
    }
    
    init(movieID: Int, sessionInfoProvider: SessionInfoContaining) {
        self.movieID = movieID
        self.sessionInfoProvider = sessionInfoProvider
    }
    
    // MARK: - API Calls
    
    public func loadInfo() {
        let params: [String: AnyObject] = ["append_to_response": "credits,trailers" as AnyObject]
        
        let configuration = MovieDetailConfiguration(movieID: movieID)
        
        Alamofire.request(APIRouter.request(config: configuration, queryParams: params, bodyParams: nil))
            .responseObject { (response: DataResponse<MovieInfo>) in
                
                switch response.result {
                case .success(let data):
                    self.delegate?.movieInfoManager(self, didLoadInfo: data, forMovieWIthID: self.movieID)
                case .failure(let error):
                    if let error = error as? APIError {
                         self.delegate?.movieInfoManager(self, didFailWithErorr: error)
                    } else {
                         self.delegate?.movieInfoManager(self, didFailWithErorr: .generic)
                    }
                }
        }
    }

    public func toggleStatusOfMovieInList(_ list: TMDbAccountList, status: Bool) {
        guard let sessionID = sessionInfoProvider.sessionID, let userID = sessionInfoProvider.user?.id else {
            delegate?.movieInfoManager(self, didFailWithErorr: .unAuthorized)
            return
        }
        
        let params: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        let body: [String: AnyObject] = ["media_type": "movie" as AnyObject, "media_id": movieID as AnyObject, list.name: status as AnyObject]
        
        let configuration = ListStatusConfiguration(userID: userID, list: list)
        
        Alamofire.request(APIRouter.request(config: configuration, queryParams: params, bodyParams: body))
            .responseJSON { (response) in
                
                guard response.result.error == nil else {
                    let error = APIErrorHandler.categorize(error: response.result.error!)
                    self.delegate?.movieInfoManager(self, didFailWithErorr: error)
                    return
                }
        }
    }

    public func loadAccountState() {
        guard let sessionID = sessionInfoProvider.sessionID else {
            delegate?.movieInfoManager(self, didFailWithErorr: .unAuthorized)
            return
        }
        
        let params: [String: AnyObject] = ["session_id": sessionID as AnyObject]
        
        let configuration = AccountStateConfiguration(movieID: movieID)
        
        Alamofire.request(APIRouter.request(config: configuration, queryParams: params, bodyParams: nil))
            .responseObject { (response: DataResponse<AccountState>) in
                
                switch response.result {
                case .success(let data):
                    self.delegate?.movieInfoManager(self, movieWithID: self.movieID, inFavorites: data.favoriteStatus, inWatchList: data.watchlistStatus)
                case .failure(let error):
                    if let error = error as? APIError {
                        self.delegate?.movieInfoManager(self, didFailWithErorr: error)
                    } else {
                        self.delegate?.movieInfoManager(self, didFailWithErorr: .generic)
                    }
                }
        }

    }
    
}
