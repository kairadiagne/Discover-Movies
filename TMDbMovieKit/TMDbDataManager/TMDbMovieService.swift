//
//  TMDbMovieService.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

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