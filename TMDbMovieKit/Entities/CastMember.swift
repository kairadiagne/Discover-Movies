//
//  CastMember.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct CastMember: PersonRepresentable, Equatable {
    public let id: Int
    public let castID: Int
    public let creditID: String
    public let name: String
    public fileprivate(set) var profilePath: String?
    public let character: String
    public let order: Int
}

public func ==(lhs: CastMember, rhs: CastMember) -> Bool {
    return lhs.id == rhs.id
}

extension CastMember: DictionarySerializable {
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int,
            let castID = dict["cast_id"] as? Int,
            let creditID = dict["credit_id"] as? String,
            let name = dict["name"] as? String,
            let character = dict["character"] as? String,
            let order = dict["order"] as? Int else {
                return nil 
        }
        
        self.id = id
        self.castID = castID
        self.creditID = creditID
        self.name = name
        self.profilePath = dict["profile_path"] as? String
        self.character = character
        self.order = order
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }
    
}
