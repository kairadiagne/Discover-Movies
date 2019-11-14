//
//  MovieDetailManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class MovieDetailManager: DataManager<MovieInfo> {
    
    // MARK: - Properties

    public var movieInfo: MovieInfo? {
        return cachedData.data
    }

    /// The state of the movie in the favorites and watch list.
    public private(set) var accountState: AccountState?

    /// The identifier of the movie for which to get the details.
    private let movieID: Int

    // MARK: - Initialize
    
    public init(movieID: Int) {
        self.movieID = movieID
        super.init(request: ApiRequest.movieDetail(movieID: movieID), refreshTimeOut: 0, cacheIdentifier: "\(movieID)")
    }

    /// Changes the status of the movie in the specified list.
    /// - Parameter list: The list to add or remove the movie to.
    /// - Parameter status: True will add the movie to the list, false will remove the movie from the list.
    public func toggleStatusOfMovieInList(_ list: TMDbAccountList, status: Bool) {
    }

    /// Loads the status fo the movie in the watchlist and favoriteslist.
    public func loadAccountState() {
    }
}

//        guard let sessionID = sessionInfoProvider.accessToken else {
//            delegate?.movieInfoManager(self, didFailWithErorr: .unAuthorized)
//            return
//        }
//
//        let request = ApiRequest.accountState(movieID: movieID, sessionID: sessionID)
//
//        Alamofire.request(request)
//            .responseObject { (response: DataResponse<AccountState>) in
//
//                switch response.result {
//                case .success(let data):
//                    self.delegate?.movieInfoManager(self, movieWithID: self.movieID, inFavorites: data.favoriteStatus, inWatchList: data.watchlistStatus)
//                case .failure(let error):
//                    if let error = error as? APIError {
//                        self.delegate?.movieInfoManager(self, didFailWithErorr: error)
//                    } else {
//                        self.delegate?.movieInfoManager(self, didFailWithErorr: .generic)
//                    }
//                }
//        }


//        guard let sessionID = sessionInfoProvider.sessionID, let userID = sessionInfoProvider.user?.identifier else {
//            delegate?.movieInfoManager(self, didFailWithErorr: .unAuthorized)
//            return
//        }
//
//        Alamofire.request(ApiRequest.setMovieStatus(status: status, movieID: movieID, in: list, userID: userID, sessionID: sessionID))
//            .responseJSON { (response) in
//
//                guard response.result.error == nil else {
//                    // swiftlint:disable:next force_unwrapping
//                    let error = APIErrorHandler.categorize(error: response.result.error!)
//                    self.delegate?.movieInfoManager(self, didFailWithErorr: error)
//                    return
//                }
//        }
