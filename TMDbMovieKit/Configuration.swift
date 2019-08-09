//
//  Configuration.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 09/08/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

struct Configuration {

    static var shared: Configuration {
        guard let shared = _shared else {
            // error
            fatalError()
        }
        return shared
    }

    private static var _shared: Configuration!

    let apiKey: String

    static func configure(apiKey: String) {
        _shared = Configuration(apiKey: apiKey)
    }
}
