//
//  Video.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Video: Equatable {
    public let name: String
    public let source: String
    public let size: String
    public let type: String
}

extension Video {
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let source = dict["source"] as? String,
            let name = dict["name"] as? String,
            let size = dict["size"] as? String,
            let type = dict["type"] as? String else {
                return nil
        }
        
        self.name = name
        self.source = source
        self.size = size
        self.type = type
        
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["name"] = name as AnyObject?
        dictionary["source"] = source as AnyObject?
        dictionary["size"] = size as AnyObject?
        dictionary["type"] = type as AnyObject?
        return dictionary
    }
}
