//
//  BaseCollectionViewDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-06-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import UIKit

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
