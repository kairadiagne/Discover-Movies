//
//  TMDbReview.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Review: DictionaryRepresentable, Equatable {
    
    public let id: String
    public let author: String
    public let content: String
    public let url: NSURL
    
    init?(dictionary dict: [String : AnyObject]) {
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
    
    func dictionaryRepresentation() -> [String : AnyObject] {
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






import ObjectMapper

public struct TMDbReview: Mappable {
    
    struct Keys {
        static let ReviewID = "id"
        static let Author = "author"
        static let Content = "content"
        static let URL = "url"
    }

    public var reviewID: Int = 0
    public var author: String?
    public var content: String?
    public var path: String?

    
    public init?(_ map: Map) {
        guard map.JSONDictionary[Keys.ReviewID] != nil else { return nil }
    }
    
    public mutating func mapping(map: Map) {
        self.reviewID  <- map[Keys.ReviewID]
        self.author    <- map[Keys.Author]
        self.content   <- map[Keys.Content]
        self.path      <- map[Keys.URL]
    }

}










