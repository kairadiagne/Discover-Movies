//
//  Review.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Review: Equatable, Codable {
    public let id: String
    public let author: String
    public let content: String
    public let url: URL
}

extension Review {
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? String,
            let author = dict["author"] as? String,
            let content = dict["content"] as? String,
            let urlString = dict["url"] as? String,
            let url = URL(string: urlString) else {
                return nil
        }
        
        self.id = id
        self.author = author
        self.content = content
        self.url = url
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["id"] = id as AnyObject?
        dictionary["author"] = author as AnyObject?
        dictionary["content"] = content as AnyObject?
        dictionary["url"] = url as AnyObject?
        return dictionary
    }
}
