//
//  BaseTableViewDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

class BaseTableViewDataSource<Item, Cell: NibReusable & UITableViewCell>: NSObject, UITableViewDataSource {
    
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
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: NoDataCellType.reuseId, for: indexPath) as! NoDataCellType
            cell.configure(with: emptyMessage)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CellType
            configure(cell, atIndexPath: indexPath)
            return cell
        }
    }

    func configure(_ cell: Cell, atIndexPath indexPath: IndexPath) {
        fatalError("Designated for subclass")
    }

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
