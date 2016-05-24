//
//  TMDbActor.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

private struct Keys {
    static let CreditID = "credit_id"
    static let Name = "name"
    static let PersonID = "id"
    static let CastID = "cast_id"
    static let Character = "character"
    static let Order = "order"
    static let Profile_path = "profile_path"
}

public class TMDbCastMember: NSObject, Mappable {
    
    public var creditID: String = ""
    public var personID: Int = 0
    public var castID = 0
    public var name: String = ""
    public var character: String?
    public var order: Int?
    public var profilePath: String?
    
    public required init?(_ map: Map) {
        super.init()
        
        guard map[Keys.CreditID].value() != nil else { return nil }
        guard map[Keys.PersonID].value() != nil else { return nil }
        guard map[Keys.CastID].value() != nil else { return nil }
        guard map[Keys.Name].value() != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.creditID       <- map[Keys.CreditID]
        self.personID       <- map[Keys.PersonID]
        self.castID         <- map[Keys.CastID]
        self.name           <- map[Keys.Name]
        self.character      <- map[Keys.Character]
        self.order          <- map[Keys.Order]
        self.profilePath    <- map[Keys.Profile_path]
    }
    
}



