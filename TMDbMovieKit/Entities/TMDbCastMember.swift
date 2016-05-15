//
//  TMDbActor.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct Keys {
    static let CreditID = "credit_id"
    static let Name = "name"
    static let ID = "id"
    static let CastID = "cast_id"
    static let Character = "character"
    static let Order = "order"
    static let Profile_path = "profile_path"
}

public struct TMDbCastMember: JSONSerializable, Equatable {
    public var creditID: String?
    public var name: String?
    public var personID: Int?
    public var castID: Int?
    public var character: String?
    public var order: Int?
    public var profilePath: String?
    
    public init?(json: SwiftyJSON.JSON) {
        self.creditID = json[Keys.CreditID].string
        self.name = json[Keys.Name].string
        self.personID = json[Keys.ID].int
        self.castID = json[Keys.CastID].int
        self.character = json[Keys.Character].string
        self.order = json[Keys.Order].int
        self.profilePath = json[Keys.Profile_path].string
    }
   
}

public func ==(rhs: TMDbCastMember, lhs: TMDbCastMember) -> Bool {
    return rhs.personID == lhs.personID
}



