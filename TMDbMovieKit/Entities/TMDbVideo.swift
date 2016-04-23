//
//  TMDbVideo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct TMDbVideo: ResponseJSONObjectSerializable, Equatable {
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
    if lhs.videoID != rhs.videoID { return false }
    if lhs.key != rhs.key { return false }
    if lhs.name != rhs.name { return false }
    if lhs.site != rhs.site { return false }
    if lhs.size != rhs.size { return false }
    if lhs.type != rhs.type { return false }
    return true
}