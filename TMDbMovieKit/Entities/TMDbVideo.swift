//
//  TMDbVideo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

private struct Keys {
    static let VideoID = "id"
    static let Key = "key"
    static let Name = "name"
    static let Site = "site"
    static let Size = "size"
    static let VideoType = "type"
}

public class TMDbVideo: NSObject, Mappable {
    
    public var videoID: Int = 0
    public var key: String = ""
    public var site: String = ""
    public var name: String?
    public var size: String?
    public var type: String?
    
    public required init?(_ map: Map) {
        guard map[Keys.VideoID].value() != nil else { return nil }
        guard map[Keys.Key].value() != nil else { return nil }
        guard map[Keys.Site].value() != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.videoID    <- map[Keys.VideoID]
        self.key        <- map[Keys.Key]
        self.name       <- map[Keys.Name]
        self.site       <- map[Keys.Site]
        self.size       <- map[Keys.Size]
        self.type       <- map[Keys.VideoType]
    }
    
}
