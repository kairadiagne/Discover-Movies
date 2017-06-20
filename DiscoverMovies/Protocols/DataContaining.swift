//
//  DataContaining.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 24-09-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import UIKit

protocol DataContaining: class {
    associatedtype ItemType
    associatedtype NoDataCellType: NibReusabelCell, NoDataMessageConfigurable
    associatedtype CellType: NibReusabelCell
    var items: [ItemType] { get set }
    var numberOfItems: Int { get }
    func item(atIndex index: Int) -> ItemType?
    func configure(_ cell: CellType, atIndexPath indexPath: IndexPath)
    func clear()
}

extension DataContaining {
    
    var isEmpty: Bool {
        return items.isEmpty
    }

    var itemCount: Int {
        return items.count
    }
    
    var numberOfItems: Int {
        return isEmpty ? 1 : itemCount
    }
    
    func item(atIndex index: Int) -> ItemType? {
        guard index >= 0 && index <= itemCount && !isEmpty else { return nil }
        return items[index]
    }
    
    func clear() {
        items.removeAll()
    }
    
}
