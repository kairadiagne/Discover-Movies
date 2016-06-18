//
//  TMDbMovieInfoManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbMovieInfoManager: TMDbBaseDataManager {
    
    // MARK: Properties

    public var similarMovies: [TMDbMovie]? {
        return movieInfo?.similarMovies?.items
    }
    
    public var cast: [TMDbCastMember]? {
        return movieInfo?.credits?.cast
    }
    
    public var crew: [TMDbCrewMember]? {
        return movieInfo?.credits?.crew
    }
    
    public var trailer: TMDbVideo? {
        return movieInfo?.trailers?.first
    }
    
    public var trailers: [TMDbVideo]? {
        return movieInfo?.trailers
    }
    
    public var accountState: TMDbAccountState?
    
    private var movieInfo: TMDbMovieInfo?
    
    private let movieClient = TMDbMovieClient()
    
    // MARK: - API Calls
    
    public func loadInfoAboutMovieWithID(movieID: Int) {
        movieClient.fetchAdditionalInfoMovie(movieID) { (response) in
            guard response.error == nil else {
                self.handleError(response.error!)
                return
            }
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { 
                if  let movieInfo = response.value {
                    self.movieInfo = movieInfo
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.state = .DataDidLoad
                    })
                }
            })
        }
    }
    
    public func loadAccountStateForMovieWithID(movieID: Int) {
        movieClient.accountStateForMovie(movieID) { (response) in
            
            guard response.error == nil else {
//                self.handleError(response.error!)
                return
            }
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                if let accountState = response.state {
                    self.accountState = accountState
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.state = .DataDidLoad
                    })
                }
            })
        }
    }
    
    public func toggleStateOfMovieInList(movieID: Int, list: TMDbAccountList) {
        guard let accountState = accountState else { return }
        
        switch list {
        case .Favorites:
            changeStateForMovie(movieID, inList: list.rawValue, toState: !accountState.favoriteStatus)
        case .Watchlist:
            changeStateForMovie(movieID, inList: list.rawValue, toState: !accountState.watchlistStatus)
        }
    }
    
    private func changeStateForMovie(movieID: Int, inList list: String, toState state: Bool) {
        movieClient.changeStateForMovie(movieID, inList: list, toState: state) { (error) in
            guard error == nil else {
                self.handleError(error!)
                return
            }
        }
    }

}