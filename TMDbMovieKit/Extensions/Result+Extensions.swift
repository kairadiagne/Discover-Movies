//
//  Result+Extensions.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 14/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

extension Result {

    /// Returns the Error in case Result is a failure.
    var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }

    /// Returns the associated value in case Result is success.
    var value: Success? {
        switch self {
        case .success(let success):
            return success
        default:
            return nil
        }
    }
}
