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
    
    var page: Int = 0
    var pageCount: Int = 0
    var resultCount: Int = 0
    var items: [Item] = []
    
    var nextPage: Int? {
        return page < pageCount ? page + 1 : nil
    }

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
    
    // MARK: Update

    func update(data: TMDbList<Item>) -> Bool {
        // Check equality of data 
        guard data != self else { return false }
        
        // Handle results
        page = data.page
        pageCount = data.pageCount
        resultCount = data.resultCount
        
        if self.page > 1 {
            items.appendContentsOf(data.items)
        } else {
            items = data.items
        }
        
        return true 
    }
    
}
