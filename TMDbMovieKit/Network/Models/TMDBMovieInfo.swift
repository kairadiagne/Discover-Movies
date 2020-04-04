//
//  TMDBMovieInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDBMovieInfo: Decodable {

    // MARK: Properties

    public let movie: TMDBMovie
    public let trailers: [TMDBVideo]
    public let cast: [TMDBCastMember]
    public let crew: [TMDBCrewMember]

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
    
    enum TrailerKeys: String, CodingKey {
        case youtube
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if let movie = try? values.decodeIfPresent(TMDBMovie.self, forKey: .movie) {
            self.movie = movie
        } else {
            movie = try TMDBMovie(from: decoder)
        }

        let trailersValues = try values.nestedContainer(keyedBy: TrailerKeys.self, forKey: .trailers)
        trailers = (try? trailersValues.decodeIfPresent([TMDBVideo].self, forKey: .youtube)) ?? []
        
        let creditValues = try values.nestedContainer(keyedBy: CreditKeys.self, forKey: .credits)
        crew = try creditValues.decodeIfPresent([TMDBCrewMember].self, forKey: .crew) ?? []
        cast = try creditValues.decodeIfPresent([TMDBCastMember].self, forKey: .cast) ?? []
    }
}
