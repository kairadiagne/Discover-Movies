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

class BaseTableViewDataSource<Item, Cell: NibReusabelCell>: NSObject, UITableViewDataSource, DataContaining where Cell: UITableViewCell {

    typealias ItemType = Item
    typealias NoDataCellType = NoDataCell
    typealias CellType = Cell
    
    // MARK: - Properties
    
    var items: [ItemType] = []
    
    private(set) var emptyMessage: String
    
    // MARK: - Init
    
    init(emptyMessage: String) {
        self.emptyMessage = emptyMessage
        super.init()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCellType.reuseId, for: indexPath) as! NoDataCellType
            cell.configure(with: emptyMessage)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.reuseId, for: indexPath) as! CellType
            configure(cell, atIndexPath: indexPath)
            return cell
        }
    }
    
    /// Designated for subclass
    func configure(_ cell: Cell, atIndexPath indexPath: IndexPath) {
    }

}

class BaseCollectionViewDataSource<Item, Cell: NibReusabelCell>: NSObject, UICollectionViewDataSource, DataContaining where Cell: UICollectionViewCell {
    
    typealias ItemType = Item
    typealias NoDataCellType = NoDataCollectionViewCell
    typealias CellType = Cell
    
    // MARK: - Properties 
    
    var items: [ItemType] = []
    
    private(set) var emptyMessage: String
    
    // MARK: - Initialize 
    
    init(emptyMessage: String) {
        self.emptyMessage = emptyMessage
        super.init()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCellType.reuseId, for: indexPath) as! NoDataCellType
            cell.configure(with: emptyMessage)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.reuseId, for: indexPath) as! CellType
            configure(cell, atIndexPath: indexPath)
            return cell
        }
    }
    
    /// Designated for subclass
    func configure(_ cell: Cell, atIndexPath indexPath: IndexPath) {
    }
    
}
