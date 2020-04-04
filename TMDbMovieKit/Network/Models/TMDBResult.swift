//
//  TMDBResult.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 09/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public struct TMDBResult<ModelType: Decodable>: Decodable {

    // MARK: Properties
    
    private(set) var page: Int
    private(set) var pageCount: Int
    private(set) var resultCount: Int
    private(set) var items: [ModelType] = []

    // MARK: Codable

    enum CodingKeys: String, CodingKey {
         case page
         case pageCount = "total_pages"
         case resultCount = "total_results"
         case items = "results"
     }
}
