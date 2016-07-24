////
////  TMDbMovieInfoManager.swift
////  DiscoverMovies
////
////  Created by Kaira Diagne on 12/05/16.
////  Copyright © 2016 Kaira Diagne. All rights reserved.
////
//
//import Foundation

// Here it would be a good idea to just use closures 
//
//public class TMDbMovieInfoManager: TMDbBaseDataManager {
//    
//    // MARK: Properties
//    
//    public private(set) var movie: TMDbMovie!
//    
//    public var inFavorites: Bool {
//        return movie.inFavorites
//    }
//    
//    public var inWatchList: Bool {
//        return movie.inWatchList
//    }
//
//    public var similarMovies: [TMDbMovie]? {
//        return movieInfo?.similarMovies?.items
//    }
//    
//    public var cast: [TMDbCastMember]? {
//        return movieInfo?.credits?.cast
//    }
//    
//    public var crew: [TMDbCrewMember]? {
//        return movieInfo?.credits?.crew
//    }
//    
//    public var director: TMDbCrewMember? {
//        return movieInfo?.credits?.director
//    }
//    
//    public var trailer: TMDbVideo? {
//        return movieInfo?.trailers?.first
//    }
//    
//    public var trailers: [TMDbVideo]? {
//        return movieInfo?.trailers
//    }
//    
//    private var movieInfo: TMDbMovieInfo?
//    private let movieClient = TMDbMovieClient()
//    
//    // MARK: - Initialization 
//    
//    public init(withMovie movie: TMDbMovie) {
//        self.movie = movie
//        super.init()
//        
//        self.loadInfoAboutMovieWithID(movie.movieID)
//        
//        if TMDbSessionManager().signInStatus == .Signedin {
//            self.loadAccountStateForMovie(movie.movieID)
//        }
//    }
//    
//    // MARK: - API Calls
//    
//    private func loadInfoAboutMovieWithID(movieID: Int) {
//        movieClient.fetchAdditionalInfoMovie(movieID) { (response) in
//            guard response.error == nil else {
//                self.handleError(response.error!)
//                return
//            }
//            
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { 
//                if  let movieInfo = response.value {
//                    self.movieInfo = movieInfo
//                    
//                    dispatch_async(dispatch_get_main_queue(), {
//                        self.state = .DataDidLoad
//                    })
//                }
//            })
//        }
//    }
//    
//    private func loadAccountStateForMovie(movieID: Int) {
//        movieClient.accountStateForMovie(movieID) { (response) in
//            
//            guard response.error == nil else {
//                self.handleError(response.error!) // return error if signed in
//                return
//            }
//            
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
//                if let accountState = response.state {
//                    self.movie.inFavorites = accountState.favoriteStatus
//                    self.movie.inWatchList = accountState.watchlistStatus
//                    
//                    dispatch_async(dispatch_get_main_queue(), { 
//                        self.state = .DataDidLoad
//                    })
//                }
//            })
//        }
//    }
//    
//    public func toggleStatusOfMovieInList(list: TMDbAccountList, status: Bool) {
//        changeStateForMovie(movie.movieID, inList: list, toState: status)
//    }
//    
//    private func changeStateForMovie(movieID: Int, inList list: TMDbAccountList, toState state: Bool) {
//        movieClient.changeStateForMovie(movieID, inList: list.rawValue, toState: state) { (error) in
//            guard error == nil else {
//                self.handleError(error!)
//                return
//            }
//    
//            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), {
//                switch list {
//                case .Favorites:
//                    self.movie.inFavorites = state
//                case .Watchlist:
//                    self.movie.inWatchList = state
//                }
//                
//                dispatch_async(dispatch_get_main_queue(), { 
//                    self.state = .DataDidLoad
//                })
//            })
//        }
//    }
//
//}