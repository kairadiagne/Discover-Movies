//
//  TMDbSignInServiceDelegate.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 18-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public protocol TMDbSignInServiceDelegate: class {
    func TMDbSignInServiceCouldNotObtainToken(error: NSError)
    func TMDbSignInServiceDidObtainToken(authorizeURL: NSURL?)
    func TMDbSignInServiceSignInDidComplete()
    func TMDbSignInServiceSignInDidFail(error: NSError)
}