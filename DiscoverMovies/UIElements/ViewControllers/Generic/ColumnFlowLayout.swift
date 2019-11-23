//
//  ColumnFlowLayout.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 23/11/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit

/// A collection view flow layout that based on the available width of the view displays its cells in one or multiple columns.
final class ColumnFlowLayout: UICollectionViewFlowLayout {

    /// The minimum heigt a column should have.
    private let minColumnWidth: CGFloat = 375

    /// The minimum height a cell should have.
    private let minColumHeight: CGFloat = 212

    // MARK: Layout

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumberOfColumns = Int(availableWidth / minColumnWidth)
        let widthForCells = availableWidth - minimumInteritemSpacing * CGFloat(maxNumberOfColumns)
        let cellWidth = widthForCells / CGFloat(maxNumberOfColumns).rounded(.down)
        let heightToWidthRatio = minColumHeight / minColumnWidth
        let cellHeight = heightToWidthRatio * cellWidth

        itemSize = CGSize(width: cellWidth, height: cellHeight)
        sectionInset = UIEdgeInsets(top: minimumInteritemSpacing, left: minimumInteritemSpacing, bottom: minimumInteritemSpacing, right: minimumInteritemSpacing)
        sectionInsetReference = .fromSafeArea
    }
}
