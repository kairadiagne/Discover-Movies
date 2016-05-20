//
//  TMDbMovieInfoManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class TMDbMovieInfoManager {
    
    // Public Properties
    
    public var inFavorites: Bool {
        return accountState.inFavorites
    }
    
    public var inWatchList: Bool {
        return accountState.inWatchList
    }
    
    public var similarMovies: [TMDbMovie] {
        return similarMovieResults.items
    }
    
    public private(set) var movieCredit: TMDbMovieCredit?
    
    public var video: TMDbVideo? {
        return videoResults.first
    }
    
    // Private Properties
    
    private var movieID: Int?
    
    private let movieService = TMDbMovieService()
    
    private var accountState = (inFavorites: false, inWatchList: false)
    
    private var similarMovieResults = TMDbListHolder<TMDbMovie>()
    
    private var videoResults = [TMDbVideo]()
    
    // MARK: - Initialization
    
    public init() { }
    
    // MARK: - Fetching
    
    // TODO: Maybe this should be one big appended path fetch for the movie with this ID
    
    public func reloadIfNeeded(forceOnline: Bool, movieID: Int) {
        self.movieID = movieID
        
        // Load movie info
        loadAccountState()
        loadSimilarMovies()
        loadMovieCredits()
        loadVideos()
    }
    
    func loadAccountState() {
        guard let movieID = movieID else { return }
        movieService.accountStateForMovie(movieID) { (inFavorites, inWatchList, error) in
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            if let inFavorites = inFavorites, inWatchList = inWatchList {
                self.accountState = (inFavorites: inFavorites, inWatchList: inWatchList)
                self.postUpdateNotification() // MultiThreading
            }
        }
    }
    
    func loadSimilarMovies() {
        guard let movieID = movieID else { return }
        movieService.fetchMoviesSimilarToMovie(withID: movieID, page: nil) { (result, error) in
            guard error == nil else {
                self.postErrorNotification(error!)
                return
            }
            
            if let result = result {
                self.similarMovieResults.update(result)
                self.postUpdateNotification() // Multithreading
            }
        }
    }
    
    func loadMovieCredits() {
        guard let movieID = movieID else { return }
        movieService.fetchCreditsForMovie(withID: movieID) { (credit, error) in
            guard error == nil else {
                print(error!)
                self.postErrorNotification(error!)
                return
            }
            
            if let credit = credit {
                self.movieCredit = credit
                self.postUpdateNotification() // Multithreading
            }
        }
    }
    
    func loadVideos() {
        guard let movieID = movieID else { return }
        movieService.fetchVideosForMovie(movieID) { (result, error) in
            guard error == nil else {
                return
            }
            
            if let result = result {
                self.videoResults = result // Multithreading
            }
        }
    }
    
    // MARK: - Notifications
    
    func postUpdateNotification() {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(TMDbManagerDataDidUpdateNotification, object: nil)
    }
    
    func postErrorNotification(error: NSError) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(TMDbManagerDidReceiveErrorNotification, object: nil, userInfo: ["error": error])
    }

}