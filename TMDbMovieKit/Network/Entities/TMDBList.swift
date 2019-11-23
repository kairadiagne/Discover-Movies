//
//  TMDBList.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDBList<ModelType: Codable>: Codable {
    
    // MARK: Properties
    
    private(set) var page: Int
    private(set) var pageCount: Int
    private(set) var resultCount: Int
    private(set) var items: [ModelType] = []
    
    var nextPage: Int? {
        return page < pageCount ? page + 1 : nil
    }

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
         case page
         case pageCount = "total_pages"
         case resultCount = "total_results"
         case items = "results"
     }
    
    // MARK: Update
    
    mutating func update(withNetxPage page: Int, pageCount: Int, resultCount: Int, items: [ModelType]) {
        self.page = page
        self.pageCount = pageCount
        self.resultCount = resultCount
        self.items.append(contentsOf: items)
    }
}
