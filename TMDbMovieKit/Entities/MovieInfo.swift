//
//  MovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 12/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieInfo: Decodable {

    // MARK: Properties

    public let movie: Movie
    public let trailers: [Video]
    public let cast: [CastMember]
    public let crew: [CrewMember]
    
    public var trailer: Video? {
        return trailers.filter { $0.type == "Trailer" }.first
    }
    
    public var director: CrewMember? {
        return crew.filter { return $0.job == "Director" }.first ?? nil
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
        case trailers
        case credits
    }

    enum CreditKeys: String, CodingKey {
        case cast
        case crew
    }

    public init(from decoder: Decoder) throws {
        movie = try Movie(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trailers = try values.decodeIfPresent([Video].self, forKey: .trailers) ?? []
        let credits = try values.nestedContainer(keyedBy: CreditKeys.self, forKey: .credits)
        crew = try credits.decodeIfPresent([CrewMember].self, forKey: .crew) ?? []
        cast = try credits.decodeIfPresent([CastMember].self, forKey: .cast) ?? []
    }
}
