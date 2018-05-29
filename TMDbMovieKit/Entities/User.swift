//
//  User.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct User: Equatable {
    public let id: Int
    public let userName: String
    public private(set) var name: String?
    public private(set) var profileHash: String?
}

extension User {
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int, let userName = dict["username"] as? String else { return nil }
        
        self.id = id
        self.userName = userName
        self.name = dict["name"] as? String
        
        if let avatar = dict["avatar"] as? [String: AnyObject],
            let gravatar = avatar["gravatar"] as? [String: AnyObject],
            let hash = gravatar["hash"] as? String {
            self.profileHash = hash
        }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["id"] = id as AnyObject
        dictionary["username"] = userName as AnyObject
        dictionary["name"] = name as AnyObject
        
        var gravatarDict = [String: [String: AnyObject]]()
        gravatarDict["gravatar"] = ["hash": profileHash as AnyObject]
        
        dictionary["avatar"] = gravatarDict as AnyObject
        
        return dictionary
    }
}
