//
//  Result+Extensions.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 14/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

extension Result {

    var error: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}
