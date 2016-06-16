//
//  DataProvider.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 15/06/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: DataProvider

protocol DataProvider: class {
    associatedtype Item: Mappable
    associatedtype Cell: UITableViewCell
    var cellIdentifier: String { get }
    var itemCount: Int { get }
    var items: [Item] { get set }
    func itemAtIndex(index: Int) -> Item?
    func updateWithItems(items: [Item])
}

// MARK: Default Implementation DataProvider

extension DataProvider {
    
    var cellIdentifier: String {
        return Cell.defaultIdentifier()
    }
    
    var itemCount: Int {
        return items.count
    }
    
    func itemAtIndex(index: Int) -> Item? {
        guard index >= 0 && index <= itemCount else { return nil }
        return items[index]
    }
    
    func updateWithItems(items: [Item]) {
        self.items = items
    }
    
}

