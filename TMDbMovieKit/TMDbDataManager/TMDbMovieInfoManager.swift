//
//  TMDbMovieInfoManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbMovieInfoManager: TMDbDataManager {
    
    // MARK: Properties
    
    public var inProgress = false
    
    public var similarMovies: [TMDbMovie]? {
        return movieInfo?.similarMovies?.items
    }
    public var accountState: TMDbAccountState?
    
    public var movieCredit: TMDbMovieCredit? {
        return movieInfo?.credits
    }
    
    public var trailers: [TMDbVideo]? {
        return movieInfo?.trailers
    }
    
    private var movieInfo: TMDbMovieInfo?
    
    private let movieClient = TMDbMovieClient()
    
    // MARK: - Initializers
    
    public init() { }
    
    // MARK: - Fetching
    
    public func loadInfoAboutMovieWithID(movieID: Int) {
        movieClient.fetchAdditionalInfoMovie(movieID) { (response) in
            guard response.error == nil else {
                self.postErrorNotification(response.error!)
                return
            }
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { 
                if  let movieInfo = response.value {
                    self.movieInfo = movieInfo
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.postUpdateNotification()
                    })
                }
            })
        }
    }
    
    public func loadAccountStateForMovieWithID(movieID: Int) {
        movieClient.accountStateForMovie(movieID) { (response) in
            
            guard response.error == nil else {
                self.postErrorNotification(response.error!)
                return
            }
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
                if let accountState = response.state {
                    self.accountState = accountState
                    
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.postUpdateNotification()
                    })
                }
            })
        }
    }
    
    public func toggleStateOfMovieInList(state: Bool, movieID: Int, list: TMDbAccountList) {
        movieClient.changeStateForMovie(movieID, inList: list.rawValue, toState: state) { (error) in
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            self.postUpdateNotification()
            
        }
    }

}