//
//  TMDbList.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

private struct Keys {
    static let Page = "page"
    static let NextPage = "nextpage"
    static let PageCount = "total_pages"
    static let ResultCount = "total_results"
    static let Items = "results"
}

class TMDbList<Item: Mappable>: NSObject, Mappable {
    
    // MARK: Properties
    
    var page: Int = 0
    var pageCount: Int = 0
    var resultCount: Int = 0
    var items: [Item] = []
    
    var nextPage: Int? {
        return page < pageCount ? page + 1 : nil
    }
    
    // MARK: Initialization

    override init() {
        super.init()
    }
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        self.page         <- map[Keys.Page]
        self.pageCount    <- map[Keys.PageCount]
        self.resultCount  <- map[Keys.ResultCount]
        self.items        <- map[Keys.Items]
    }
    
}
