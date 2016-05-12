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
    
    public func reloadIfNeeded(forceOnline: Bool, movieID: Int) {
        self.movieID = movieID
        
    }
    
    func loadAccountState() {
        guard let movieID = movieID else { return }
        movieService.accountStateForMovie(movieID) { (inFavorites, inWatchList, error) in
            guard error != nil else {
                // Error notification
                return
            }
            
            if let inFavorites = inFavorites, inWatchList = inWatchList {
                self.accountState = (inFavorites: inFavorites, inWatchList: inWatchList)
            }
        }
    }
    
    func loadSimilarMovies() {
        guard let movieID = movieID else { return }
        movieService.fetchMoviesSimilarToMovie(withID: movieID, page: nil) { (result, error) in
            guard error != nil else {
                // Error notification
                return
                
            }
        }
    }
    
    func loadMovieCredits() {
        guard let movieID = movieID else { return }
        movieService.fetchCreditsForMovie(withID: movieID) { (credit, error) in
            guard error != nil else {
                // Error notification
                return
                
            }
        }
    }
    
    func loadVideos() {
        guard let movieID = movieID else { return }
        movieService.fetchVideosForMovie(movieID) { (result, error) in
            guard error != nil else {
                // Error notification
                return
                
            }
        }
    }
    
    
}