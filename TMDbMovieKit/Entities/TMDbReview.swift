//
//  TMDbReview.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct Keys {
    static let ReviewID = "id"
    static let Author = "author"
    static let Content = "content"
    static let URL = "url"
}

public struct TMDbReview: JSONSerializable {
    public var reviewID: Int?
    public var author: String?
    public var content: String?
    public var url: NSURL?
    
    public init?(json: SwiftyJSON.JSON) {
        self.reviewID = json[Keys.ReviewID].int
        self.author = json[Keys.Author].string
        self.content = json[Keys.Content].string
        guard let urlString = json[Keys.URL].string else { return }
        self.url = NSURL(string: urlString)
    }
    
}

public func ==(lhs: TMDbReview, rhs: TMDbReview) -> Bool {
    return lhs.reviewID == rhs.reviewID
}








