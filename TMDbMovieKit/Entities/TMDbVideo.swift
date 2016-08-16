//
//  TMDbVideo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Video: DictionaryRepresentable {
    
    public let name: String
    public let source: String
    public let size: String
    public let type: String
    
    init?(dictionary dict: [String : AnyObject]) {
        guard let source = dict["source"] as? String,
            name = dict["name"] as? String,
            size = dict["size"] as? String,
            type = dict["type"] as? String else {
                return nil
        }
        
        self.name = name
        self.source = source
        self.size = size
        self.type = type
        
    }
    
    func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["name"] = name
        dictionary["source"] = source
        dictionary["size"] = size
        dictionary["type"] = type
        return dictionary
    }
    
}










import ObjectMapper

private struct Keys {
    static let Source = "source"
    static let Name = "name"
    static let Size = "size"
    static let VideoType = "type"
}

public class TMDbVideo: NSObject, Mappable {
    
    public var source: String = ""
    public var name: String?
    public var size: String?
    public var type: String?
    
    public required init?(_ map: Map) {
        guard map.JSONDictionary[Keys.Source] != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.source   <- map[Keys.Source]
        self.name     <- map[Keys.Name]
        self.size     <- map[Keys.Size]
        self.type     <- map[Keys.VideoType]
    }
    
}
