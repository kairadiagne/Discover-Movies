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
    var items: [ItemType] { get set } // [[ItemType]] to support IndexPath and sectionated data -> Write Unit Test !!
    var itemCount: Int { get }
    var isEmpty: Bool { get }
    // func add(items: [ItemType], for indexPath: IndexPath)
    // func item(at indexPath: IndexPath) -> ItemType
    func item(atIndex index: Int) -> ItemType?
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
    
    func clear() {
        items.removeAll()
    }
    
}


///// Retains the sections in Data Source (to make it able to support
//open var sections:Array<BaseSection>
//open var delegate: DataSourceDelegate?







    
    
    
    
    
    
    
    
    
    
    


