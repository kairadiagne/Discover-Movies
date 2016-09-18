//
//  ErrorHandling.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 18-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol ErrorHandling {
    func categorize(error: Error) -> APIError
}
