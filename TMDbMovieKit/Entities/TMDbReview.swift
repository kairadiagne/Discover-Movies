//
//  TMDbReview.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

private struct Keys {
    static let ReviewID = "id"
    static let Author = "author"
    static let Content = "content"
    static let URL = "url"
}

public class TMDbReview: NSObject, Mappable, NSCoding {
    
    public var reviewID: Int = 0
    public var author: String?
    public var content: String?
    public var path: String?
    
    public required init?(_ map: Map) {
        super.init()
        
        guard map[Keys.ReviewID].value() != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.reviewID   <- map[Keys.ReviewID]
        self.author     <- map[Keys.Author]
        self.content    <- map[Keys.Content]
        self.path       <- map[Keys.URL]
    }
    
    // MARK: - NSCoding
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(reviewID, forKey: Keys.ReviewID)
        aCoder.encodeObject(author, forKey: Keys.Author)
        aCoder.encodeObject(content, forKey: Keys.Content)
        aCoder.encodeObject(path, forKey: Keys.URL)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        guard let reviewID = aDecoder.decodeObjectForKey(Keys.ReviewID) as? Int else { return nil }
        
        super.init()
        
        self.reviewID = reviewID
        self.author = aDecoder.decodeObjectForKey(Keys.Author) as? String
        self.content = aDecoder.decodeObjectForKey(Keys.Content) as? String
        self.path = aDecoder.decodeObjectForKey(Keys.URL) as? String
    }

}









