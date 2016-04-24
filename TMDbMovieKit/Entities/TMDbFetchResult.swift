//
//  TMDbFetchResult.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct TMDbFetchResult<Item: ResponseJSONObjectSerializable>: ResponseJSONObjectSerializable {
    public var page: Int
    public var totalPages: Int
    public var nextPage: Int?
    public var totalResults: Int
    public var items: [Item] = []
    
    public init?(json: SwiftyJSON.JSON) {
        self.page = json["page"].intValue
        self.totalPages = json["total_pages"].intValue
        self.nextPage = self.page < self.totalPages ? self.page + 1 : nil
        self.totalResults = json["total_results"].intValue
        self.items = json["results"].flatMap { Item(json: $0.1) }
    }
    
}

