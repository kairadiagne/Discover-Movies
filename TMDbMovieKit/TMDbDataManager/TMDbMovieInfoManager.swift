//
//  TMDbMovieInfoManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbMovieInfoManager {
    
    private let movieClient = TMDbMovieClient()
    
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
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Fetching
    
    public func loadInfoAboutMovieWithID(movieID: Int) {
        movieClient.fetchAdditionalInfoMovie(movieID) { (response) in
            
            guard response.error == nil else {
                self.postErrorNotification(response.error!)
                return
            }
            
            if  let movieInfo = response.value {
                self.movieInfo = movieInfo
                self.postUpdateNotification()
            }
        }
    }
    
    public func loadAccountStateForMovieWithID(movieID: Int) {
        movieClient.accountStateForMovie(movieID) { (response) in
            
            guard response.error == nil else {
                self.postErrorNotification(response.error!)
                return
            }
            
            if let accountState = response.value {
                self.accountState = accountState
                self.postUpdateNotification()
            }
        }
    }
    
    public func addMovieToList(movieID: Int, list: TMDbAccountList) {
        movieClient.changeStateForMovie(movieID, inList: list.rawValue, toState: true) { (error) in
            
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            self.postUpdateNotification()
        }
    }
    
    public func removeMovieFromList(movieID: Int, list: TMDbAccountList) {
        movieClient.changeStateForMovie(movieID, inList: list.rawValue, toState: false) { (error) in
            
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            self.postUpdateNotification()
        }
    }
    
    // MARK: - Notifications
    
    func postUpdateNotification() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(TMDbManagerDataDidUpdateNotification, object: self)
    }
    
    func postErrorNotification(error: NSError) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(TMDbManagerDidReceiveErrorNotification, object: self, userInfo: ["error": error])
    }

}