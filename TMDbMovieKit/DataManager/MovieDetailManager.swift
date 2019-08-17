//
//  MovieDetailManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import Alamofire

public protocol MovieDetailManagerDelegate: class {
    func movieInfoManager(_ manager: MovieDetailManager, didLoadInfo info: MovieInfo, forMovieWIthID id: Int)
    func movieInfoManager(_ manager: MovieDetailManager, movieWithID: Int, inFavorites: Bool, inWatchList: Bool)
    func movieInfoManager(_ manager: MovieDetailManager, didFailWithErorr error: APIError)
}

public final class MovieDetailManager {
    
    // MARK: - Properties
    
    public weak var delegate: MovieDetailManagerDelegate?
    
    public let movieID: Int
    
    private let sessionInfoProvider: SessionInfoContaining
    
    // MARK: - Initialize
    
    public convenience init(movieID: Int) {
        let sessionInfoStorage = SessionInfoStorage(keyValueStorage: UserDefaults.standard)
        self.init(movieID: movieID, sessionInfoProvider: sessionInfoStorage)
    }
    
    init(movieID: Int, sessionInfoProvider: SessionInfoContaining) {
        self.movieID = movieID
        self.sessionInfoProvider = sessionInfoProvider
    }
    
    // MARK: - API Calls
    
    public func loadAdditionalInfo() {
        let request = ApiRequest.movieDetail(movieID: movieID)
        
//        Alamofire.request(request)
////            .responseObject { (response: DataResponse<MovieInfo>) in
////                
////                switch response.result {
////                case .success(let data):
////                    self.delegate?.movieInfoManager(self, didLoadInfo: data, forMovieWIthID: self.movieID)
////                case .failure(let error):
////                    if let error = error as? APIError {
////                        self.delegate?.movieInfoManager(self, didFailWithErorr: error)
////                    } else {
////                        self.delegate?.movieInfoManager(self, didFailWithErorr: .generic)
////                    }
////                }
//        }
    }

    public func toggleStatusOfMovieInList(_ list: TMDbAccountList, status: Bool) {
        guard let sessionID = sessionInfoProvider.sessionID, let userID = sessionInfoProvider.user?.identifier else {
            delegate?.movieInfoManager(self, didFailWithErorr: .unAuthorized)
            return
        }

        Alamofire.request(ApiRequest.setMovieStatus(status: status, movieID: movieID, in: list, userID: userID, sessionID: sessionID))
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
        
        let request = ApiRequest.accountState(movieID: movieID, sessionID: sessionID)
        
        Alamofire.request(request)
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
