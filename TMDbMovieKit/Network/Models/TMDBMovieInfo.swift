//
//  TMDBMovieInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDBMovieInfo: Codable {

    // MARK: Properties

    public let movie: TMDBMovie
    public let trailers: [TMDBVideo]
    public let cast: [TMDBCastMember]
    public let crew: [TMDBCrewMember]
    
    public var trailer: TMDBVideo? {
        return trailers.filter { $0.type == "Trailer" }.first
    }
    
    public var director: TMDBCrewMember? {
        return crew.filter { return $0.job == "Director" }.first ?? nil
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case movie
        case trailers
        case credits
    }

    enum CreditKeys: String, CodingKey {
        case cast
        case crew
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if let movie = try? values.decodeIfPresent(TMDBMovie.self, forKey: .movie) {
            self.movie = movie
        } else {
            movie = try TMDBMovie(from: decoder)
        }

        trailers = (try? values.decodeIfPresent([TMDBVideo].self, forKey: .trailers)) ?? []
        let credits = try values.nestedContainer(keyedBy: CreditKeys.self, forKey: .credits)
        crew = try credits.decodeIfPresent([TMDBCrewMember].self, forKey: .crew) ?? []
        cast = try credits.decodeIfPresent([TMDBCastMember].self, forKey: .cast) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(movie, forKey: CodingKeys.movie)
        try container.encode(trailers, forKey: CodingKeys.trailers)
        var nestedContainer = container.nestedContainer(keyedBy: CreditKeys.self, forKey: .credits)
        try nestedContainer.encode(cast, forKey: CreditKeys.cast)
        try nestedContainer.encode(crew, forKey: CreditKeys.crew)
    }    
}
