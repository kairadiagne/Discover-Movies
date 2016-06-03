//
//  TMDbListHolder.swift
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
    static let TimeStamp = "timestamp"
}

class TMDbList<Item: protocol<Mappable, NSCoding>>: NSObject, Mappable, NSCoding {
    
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
        self.page           <- map[Keys.Page]
        self.pageCount      <- map[Keys.PageCount]
        self.resultCount    <- map[Keys.ResultCount]
        self.items          <- map[Keys.Items]
    }
    
    // MARK: - Update with new items 

    func update(data: TMDbList<Item>) {        
        page = data.page
        pageCount = data.pageCount
        resultCount = data.resultCount
        
        if self.page > 1 {
            self.items.appendContentsOf(data.items)
        } else {
            self.items = data.items
        }
    }
    
    // MARK: NSCoding
    
    required init?(coder aDecoder: NSCoder) {
         // TODO: - Implement
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(page, forKey: Keys.Page)
        aCoder.encodeObject(pageCount, forKey: Keys.PageCount)
        aCoder.encodeObject(nextPage, forKey: Keys.NextPage)
        aCoder.encodeObject(resultCount, forKey: Keys.ResultCount)
        aCoder.encodeObject(items, forKey: Keys.Items)
    }
    
}
