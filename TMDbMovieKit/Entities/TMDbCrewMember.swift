//
//  TMDbCrewMember.swift
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
    static let Department = "department"
    static let Job = "job"
    static let ProfilePath = "profile_path"
}

public struct TMDbCrewMember: JSONSerializable, Equatable {
    public var creditID: String?
    public var name: String?
    public var personID: Int?
    public var department: String?
    public var job: String?
    public var profilePath: String?
    
    public init?(json: SwiftyJSON.JSON) {
        self.creditID = json[Keys.CreditID].string
        self.name = json[Keys.Name].string
        self.personID = json[Keys.ID].int
        self.department = json[Keys.Department].string
        self.job = json[Keys.Job].string
        self.profilePath = json[Keys.ProfilePath].string
    }
   
}

public func ==(rhs: TMDbCrewMember, lhs: TMDbCrewMember) -> Bool {
    return rhs.personID == lhs.personID
}
