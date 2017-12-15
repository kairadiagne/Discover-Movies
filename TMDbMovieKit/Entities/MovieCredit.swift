//
//  MovieCredit.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 25-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

public struct MovieCredit: MovieRepresentable, Equatable {
    public let id: Int
    public let creditId: String
    public let title: String
    public let releaseDate: String
    public let posterPath: String
}

public func ==(lhs: MovieCredit, rhs: MovieCredit) -> Bool {
    return lhs.id == rhs.id
}

extension MovieCredit: DictionarySerializable {
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int,
            let creditId = dict["credit_id"] as? String,
            let title = dict["title"] as? String,
            let releaseDate = dict["release_date"] as? String,
            let posterPath = dict["poster_path"] as? String  else {
                return nil
        }
        
        self.id = id
        self.creditId = creditId
        self.title = title
        self.releaseDate = releaseDate
        self.posterPath = posterPath
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }
}
