//
//  TMDbUser.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct User: DictionaryRepresentable {
    
    public let id: Int
    public let userName: String
    public var name: String?
    public var profileHash: String?
    
    init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? Int, userName = dict["username"] as? String else { return nil }
        
        self.id = id
        self.userName = userName
        self.name = dict["name"] as? String
        
        if let avatar = dict["avatar"], gravatar = avatar["gravatar"], hash = gravatar?["hash"] as? String {
            self.profileHash = hash
        }
        
    }
    
    func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["id"] = id
        dictionary["username"] = userName
        dictionary["name"] = name
        
        var hashDict = [String: String?]()
        hashDict["hash"] = profileHash
        
        
        
        
        let gravatarDict = [String]
        dictionary["avatar"] = ["gravatar": hashDict]
        return dictionary
    }
    
}













import ObjectMapper

private struct Keys {
    static let UserID = "id"
    static let Name = "name"
    static let Username = "username"
    static let ProfilePath = "avatar.gravatar.hash"
}

public class TMDbUser: NSObject, Mappable, NSCoding {
    
    public var userID: Int = 0
    public var name: String?
    public var userName: String?
    public var profilePath: String?
    
    public required init?(_ map: Map) {
        super.init()
        guard map.JSONDictionary[Keys.UserID] != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.userID       <- map[Keys.UserID]
        self.name         <- map[Keys.Name]
        self.userName     <- map[Keys.Username]
        self.profilePath  <- map[Keys.ProfilePath]
    }
    
    // MARK: - NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(userID, forKey: Keys.UserID)
        aCoder.encodeObject(name, forKey: Keys.Name)
        aCoder.encodeObject(userName, forKey: Keys.Username)
        aCoder.encodeObject(profilePath, forKey: Keys.ProfilePath)
    }
    
    public required init?(coder decoder: NSCoder) {
        guard let userID = decoder.decodeObjectForKey(Keys.UserID) as? Int else { return nil }
    
        self.userID = userID
        self.name = decoder.decodeObjectForKey(Keys.Name) as? String
        self.userName = decoder.decodeObjectForKey(Keys.Username) as? String
        self.profilePath = decoder.decodeObjectForKey(Keys.ProfilePath) as? String
    }
    
}
