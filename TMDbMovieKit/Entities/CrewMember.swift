//
//  CrewMember.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct CrewMember: PersonRepresentable, Equatable {
    public let id: Int
    public let creditID: String
    public let name: String
    public var department: String
    public let job: String
    public fileprivate(set) var profilePath: String?
}

public func ==(lhs: CrewMember, rhs: CrewMember) -> Bool {
    return lhs.id == rhs.id
}

extension CrewMember: DictionarySerializable {
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int,
            let creditID = dict["credit_id"] as? String,
            let name = dict["name"] as? String,
            let department = dict["department"] as? String,
            let job = dict["job"] as? String else {
                return nil
        }
    
        self.id = id
        self.creditID = creditID
        self.name = name
        self.department = department
        self.job = job
        self.profilePath = dict["profile_path"] as? String
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }
    
}
