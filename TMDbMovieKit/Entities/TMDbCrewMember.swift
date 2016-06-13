//
//  TMDbCrewMember.swift
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
    static let Department = "department"
    static let Job = "job"
    static let ProfilePath = "profile_path"
}

public class TMDbCrewMember: NSObject, Mappable {
    
    public var creditID: String = ""
    public var personID: Int = 0
    public var name: String?
    public var department: String?
    public var job: String?
    public var profilePath: String?
    
    public required init?(_ map: Map) {
        guard map.JSONDictionary[Keys.CreditID] != nil else { return nil }
        guard map.JSONDictionary[Keys.PersonID] != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.creditID     <- map[Keys.CreditID]
        self.name         <- map[Keys.Name]
        self.personID     <- map[Keys.PersonID]
        self.department   <- map[Keys.Department]
        self.job          <- map[Keys.Job]
        self.profilePath  <- map[Keys.ProfilePath]
    }
    
    // MARK Equality
    
    override public func isEqual(object: AnyObject?) -> Bool {
        if let crewMember = object as? TMDbCrewMember {
            if creditID == crewMember.creditID && personID == crewMember.personID {
                return true
            }
        }
        return false 
    }
    
}

