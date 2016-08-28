//
//  Video.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Video: DictionaryRepresentable {
    
    // MARK: - Properties
    
    public let name: String
    public let source: String
    public let size: String
    public let type: String
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
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
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["name"] = name
        dictionary["source"] = source
        dictionary["size"] = size
        dictionary["type"] = type
        return dictionary
    }
    
}
