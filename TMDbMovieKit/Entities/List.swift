//
//  List.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct List<ModelType: Codable>: Codable {

    // MARK: - Properties
    
    private(set) var page: Int = 0
    private(set) var totalPages: Int = 0
    private(set) var totalResults: Int = 0
    private(set) var results: [ModelType] = []
    
    var nextPage: Int? {
        return page < totalPages ? page + 1 : nil
    }

    // MARK: - Codable

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results = "results"
    }

    // MARK: - Update
    
    mutating func update(withNetxPage page: Int, pageCount: Int, resultCount: Int, items: [ModelType]) {
        self.page = page
        self.totalPages = pageCount
        self.totalResults = resultCount
        self.results.append(contentsOf: items)
    }
}
