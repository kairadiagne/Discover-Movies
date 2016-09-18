//
//  TMDbAPIError.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23-07-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public enum APIError: Error {
    case generic
    case noInternetConnection
    case unAuthorized
    case timedOut
}
