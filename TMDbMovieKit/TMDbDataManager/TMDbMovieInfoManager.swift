//
//  TMDbMovieInfoManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol TMDbMovieInfoManagerDelegate: class {
    func movieInfomManagerDidLoadInfoForMovieWithID(movieID: Int, info: TMDbMovieInfo)
    func movieInfoManagerDidLoadAccoutnStateForMovieWithID(movieID: Int, inFavorites: Bool, inWatchList: Bool)
    func movieInfoManagerDidReceiverError(error: TMDbAPIError)
}

public class TMDbMovieService {
    
    // MARK: Properties
    
    public var delegate: TMDbMovieInfoManagerDelegate?
    
    // MARK: Init
    
    init() {}
    
    // MARK: Handle Error 
    
    func handleError(error: NSError) {
        var newError: TMDbAPIError
        
        // Determine which kind of error where dealing with
        if error.code == NSURLErrorNotConnectedToInternet {
            newError = .NoInternetConnection
        } else if error.domain == NSURLErrorDomain && error.code == NSURLErrorUserAuthenticationRequired {
            newError = .NotAuthorized
        } else {
            newError = .Generic
        }
        
        delegate?.movieInfoManagerDidReceiverError(newError)
    }
    
}

public class TMDbMovieInfoManager: TMDbMovieService {
    
    // MARK: Properties
    
    public private(set) var movieID: Int
    
    private let movieClient = TMDbMovieClient()
    
    // MARK: Initialization 
    
    public init(movieID: Int) {
        self.movieID = movieID
    }
    
    // MARK: API Calls 
    
    public func loadInfo() {
        movieClient.fetchAdditionalInfoMovie(movieID) { (response) in
            guard response.error == nil else {
                self.handleError(response.error!)
                return
            }
            
            if let movieInfo = response.value {
                self.delegate?.movieInfomManagerDidLoadInfoForMovieWithID(self.movieID, info: movieInfo)
            }
        }
        
    }
    
    public func toggleStatusOfMovieInList(list: TMDbAccountList, status: Bool) {
        movieClient.changeStateForMovie(movieID, inList: list.rawValue, toState: status) { (error) in
            guard error == nil else {
                self.handleError(error!)
                return
            }
        }
    }
    
    public func loadAccountState() {
        movieClient.accountStateForMovie(movieID) { (response) in
        
            guard response.error == nil else {
                self.handleError(response.error!) // return error if signed in
                return
            }
            
            if let accountState = response.state {
                self.delegate?.movieInfoManagerDidLoadAccoutnStateForMovieWithID(self.movieID, inFavorites: accountState.favoriteStatus, inWatchList: accountState.watchlistStatus)
            }
    
        }
    }
    
}
