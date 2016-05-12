//
//  TMDbUser.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 16-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TMDbUser: NSObject, NSCoding, JSONSerializable {
    public var userID: Int?
    public var name: String?
    public var userName: String?
    public var gravatarURI: String?
    
    public required init?(json: SwiftyJSON.JSON) {
        self.userID = json["id"].int
        self.name = json["name"].string
        self.userName = json["username"].string
        self.gravatarURI = json["avatar"]["gravatar"]["hash"].string
    }
    
    public init(userID: Int, name: String, userName: String, gravatarURI: String) {
        super.init()
        self.userID = userID
        self.name = name
        self.userName = userName
        self.gravatarURI = gravatarURI
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.userID, forKey: "userID")
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.userName, forKey: "userName")
        aCoder.encodeObject(self.gravatarURI, forKey: "gravatarURI")
    }
    
    public required convenience init?(coder decoder: NSCoder) {
        guard let userID = decoder.decodeObjectForKey("userID") as? Int else { return nil}
        guard let name = decoder.decodeObjectForKey("name") as? String else { return nil  }
        guard let userName = decoder.decodeObjectForKey("userName") as? String else { return nil }
        guard let gravatarURI = decoder.decodeObjectForKey("gravatarURI") as? String else { return nil }
        self.init(userID: userID, name: name, userName: userName, gravatarURI: gravatarURI)
    }
    
}
