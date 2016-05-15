//
//  TMDbVideo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct Keys {
    static let VideoID = "id"
    static let Key = "key"
    static let Name = "name"
    static let Site = "site"
    static let Size = "size"
    static let Type = "type"
}

public struct TMDbVideo: JSONSerializable, Equatable {
    public var videoID: String?
    public var key: String?
    public var name: String?
    public var site: String?
    public var size: Int?
    public var type: String?
    
    public init?(json: SwiftyJSON.JSON) {
        self.videoID = json["id"].string
        self.key = json["key"].string
        self.name = json["name"].string
        self.site = json["site"].string
        self.size = json["size"].int
        self.type = json["type"].string
    }
    
}

public func ==(lhs: TMDbVideo, rhs: TMDbVideo) -> Bool {
    return lhs.videoID == rhs.videoID
}