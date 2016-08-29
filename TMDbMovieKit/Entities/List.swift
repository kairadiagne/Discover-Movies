//
//  List.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public class List<ModelType: DictionaryRepresentable>: DictionaryRepresentable {
    
    // MARK: - Properties
    
    var page: Int
    var pageCount: Int
    var resultCount: Int
    var items: [ModelType] = []
    
    var nextPage: Int? {
        return page < pageCount ? page + 1 : nil
    }
    
    // MARK: - Initialize
    
    init() {
        self.page = 0
        self.pageCount = 0
        self.resultCount = 0
        self.items = []
    }
    
    required public init?(dictionary dict: [String : AnyObject]) {
        self.page = dict["page"] as? Int ?? 0
        self.pageCount = dict["total_pages"] as? Int ?? 0
        self.resultCount = dict["total_results"] as? Int ?? 0
        
        if let itemDicts = dict["results"] as? [[String: AnyObject]] {
            self.items = itemDicts.map { return ModelType(dictionary: $0) }.flatMap { $0 }
        }
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["page"] = page
        dictionary["total_pages"] = pageCount
        dictionary["resultCount"] = resultCount
        dictionary["results"] = items.map { return $0.dictionaryRepresentation() }
        return dictionary
    }
    
}
