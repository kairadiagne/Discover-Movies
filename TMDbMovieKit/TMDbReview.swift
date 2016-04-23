//
//  TMDbReview.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct TMDbReview: ResponseJSONObjectSerializable, Equatable {
    public var reviewID: Int?
    public var author: String?
    public var content: String?
    public var url: NSURL?
    
    public init?(json: SwiftyJSON.JSON) {
        self.reviewID = json["id"].int
        self.author = json["author"].string
        self.content = json["content"].string
        guard let urlString = json["url"].string else { return }
        self.url = NSURL(string: urlString)
    }
    
}

public func ==(lhs: TMDbReview, rhs: TMDbReview) -> Bool {
    if lhs.reviewID != rhs.reviewID { return false }
    if lhs.author != rhs.author { return false }
    if lhs.content != rhs.content { return false }
    if lhs.url != rhs.url { return false }
    return true
}








