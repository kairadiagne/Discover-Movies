//
//  CrewMember.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct CrewMember: DictionaryRepresentable, Equatable {
    
    // MARK: - Properties
    
    public let creditID: String
    public let personID: Int
    public let name: String
    public let department: String?
    public let job: String?
    public private(set) var profilePath: String?
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let creditID = dict["credit_id"] as? String,
            personID = dict["id"] as? Int,
            name = dict["name"] as? String,
            department = dict["department"] as? String,
            job = dict["job"] as? String else {
                return nil
        }
        
        self.creditID = creditID
        self.personID = personID
        self.name = name
        self.department = department
        self.job = job
        self.profilePath = dict["profile_path"] as? String
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        // No need to archive a CrewMember
        return [:]
    }
    
}

public func ==(lhs: CrewMember, rhs: CrewMember) -> Bool {
    return lhs.personID == rhs.personID
}

