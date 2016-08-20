//
//  Review.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Review: DictionaryRepresentable, Equatable {
    
    // MARK: Properties
    
    public let id: String
    public let author: String
    public let content: String
    public let url: NSURL
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let id = dict["id"] as? String,
            author = dict["author"] as? String,
            content = dict["content"] as? String,
            urlString = dict["url"] as? String,
            url = NSURL(string: urlString) else {
            return nil
        }
        
        self.id = id
        self.author = author
        self.content = content
        self.url = url
    }
    
    // MARK: Initialize 
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["id"] = id
        dictionary["author"] = author
        dictionary["content"] = content
        dictionary["url"] = url
        return dictionary
    }
    
}

public func ==(lhs: Review, rhs: Review) -> Bool {
    return  lhs.id == rhs.id ? true : false
}











