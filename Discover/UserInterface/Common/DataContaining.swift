//
//  DataContaining.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

protocol DataContaining: class {
    associatedtype ItemType
    var items: [ItemType] { get set }
    var itemCount: Int { get }
    var isEmpty: Bool { get }
    func item(atIndex index: Int) -> ItemType?
    func update(withItems items: [ItemType])
    func clear()
}

extension DataContaining {
    
    var itemCount: Int {
        return items.count
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    func item(atIndex index: Int) -> ItemType? {
        guard index >= 0 && index <= itemCount && !isEmpty else { return nil }
        return items[index]
    }
    
    func update(withItems items: [ItemType]) {
        self.items = items
    }
    
    func clear() {
        items.removeAll()
    }
    
}







    
    
    
    
    
    
    
    
    
    
    
    


