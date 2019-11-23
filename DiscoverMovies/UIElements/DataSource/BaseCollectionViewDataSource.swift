//
//  BaseCollectionViewDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

class BaseCollectionViewDataSource<Item, Cell: Reusable & UICollectionViewCell>: NSObject, UICollectionViewDataSource {
    
    typealias ItemType = Item
    typealias NoDataCellType = NoDataCollectionViewCell
    typealias CellType = Cell
    
    // MARK: - Properties
    
    var items: [ItemType] = []
    
    private(set) var emptyMessage: String?
    
    // MARK: - Initialize
    
    init(emptyMessage: String?) {
        self.emptyMessage = emptyMessage
        super.init()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if shouldShowEmptyMessage {
            // swiftlint:disable force_cast
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as NoDataCellType
            cell.configure(with: emptyMessage ?? "")
            return cell
        } else {
            // swiftlint:disable force_cast
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CellType
            configure(cell, atIndexPath: indexPath)
            return cell
        }
    }
    
    /// Designated for subclass
    func configure(_ cell: Cell, atIndexPath indexPath: IndexPath) {
        fatalError("Designated for subclass")
    }

    var shouldShowEmptyMessage: Bool {
        return items.isEmpty && emptyMessage != nil
    }

    var itemCount: Int {
        return items.count
    }

    var numberOfItems: Int {
        return shouldShowEmptyMessage ? 1 : itemCount
    }

    func item(atIndex index: Int) -> ItemType? {
        guard index >= 0 && index <= itemCount && !shouldShowEmptyMessage else { return nil }
        return items[index]
    }

    func clear() {
        items.removeAll()
    }
}
