//
//  TMDbListHolder.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

private struct Keys {
    static let Page = "page"
    static let NextPage = "nextpage"
    static let PageCount = "total_pages"
    static let ResultCount = "total_results"
    static let Items = "results"
    static let TimeStamp = "timestamp"
}

public struct TMDbListHolder<Item: JSONSerializable>: JSONSerializable  {
    var page: Int = 0
    var pageCount: Int = 0
    var nextPage: Int?
    var resultCount: Int = 0
    var items: [Item] = []
    var timeStamp: NSDate?
    
    init() { }
    
    public init?(json: SwiftyJSON.JSON) {
        self.page = json[Keys.Page].intValue
        self.pageCount = json[Keys.PageCount].intValue
        self.nextPage = self.page < self.pageCount ? self.page + 1 : nil
        self.resultCount = json[Keys.ResultCount].intValue
        self.items = json[Keys.Items].flatMap { Item(json: $0.1) }
        self.timeStamp = NSDate()
    }
    
    // MARK: - Updating Data
    
    mutating func update(list: TMDbListHolder<Item>) {
        self.page = list.page
        self.nextPage = list.nextPage
        self.pageCount = list.pageCount
        self.resultCount = list.resultCount
            
        if self.page > 1 {
            self.items.appendContentsOf(list.items)
        } else {
            self.items = list.items
        }
       
    }
    
}




