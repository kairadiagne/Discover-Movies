//
//  CastMember.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct CastMember: DictionarySerializable, Equatable {
    
    // MARK: - Properties
    
    public let creditID: String
    public let personID: Int
    public let castID: Int
    public let name: String
    public let character: String
    public let order: Int
    public fileprivate(set) var profilePath: String?
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let creditID = dict["credit_id"] as? String,
            let personID = dict["id"] as? Int,
            let castID = dict["cast_id"] as? Int,
            let name = dict["name"] as? String,
            let character = dict["character"] as? String,
            let order = dict["order"] as? Int else {
                return nil
        }
        
        self.creditID = creditID
        self.personID = personID
        self.castID = castID
        self.name = name
        self.character = character
        self.order = order
        self.profilePath = dict["profile_path"] as? String
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }
    
}

public func ==(lhs: CastMember, rhs: CastMember) -> Bool {
    return lhs.personID == rhs.personID
}



