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

public class TMDbReview: NSObject, Mappable {
    
    public var reviewID: Int = 0
    public var author: String?
    public var content: String?
    public var path: String?
    
    public required init?(_ map: Map) {
        guard map.JSONDictionary[Keys.ReviewID] != nil else { return nil }
    }
    
    public func mapping(map: Map) {
        self.reviewID  <- map[Keys.ReviewID]
        self.author    <- map[Keys.Author]
        self.content   <- map[Keys.Content]
        self.path      <- map[Keys.URL]
    }

    // MARK: Equality
    
    override public func isEqual(object: AnyObject?) -> Bool {
        if let review = object as? TMDbReview {
            return reviewID == review.reviewID
        }
        return false 
    }

}









