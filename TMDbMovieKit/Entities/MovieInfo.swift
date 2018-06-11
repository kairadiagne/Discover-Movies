//
//  MovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieInfo: Equatable, Codable {

    // MARK: - Properties

    public let movie: Movie
    public let trailers: [Video] = []
    public let cast: [CastMember] = []
    public let crew: [CrewMember] = []

    public var trailer: Video? {
        return trailers.filter { $0.type == "Trailer" }.first
    }

    public var director: CrewMember? {
        return crew.filter { return $0.job == "Director" }.first ?? nil
    }
}
