//
//  TMDBVideo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDBVideo: Decodable {

    // MARK: Properties

    public let name: String
    public let size: String
    public let source: String
    public let type: String
}
