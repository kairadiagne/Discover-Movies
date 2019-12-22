//
//  CollectionViewFetchedResultsDataSource.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 14/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import UIKit
import CoreData

/// A generic UICollectionView datasource object powered by a fetchedResultsController.
/// It was inspired by the CollectionViewDataSource from the book "Core Data" by objc.io.
class CollectionViewFetchedResultsDataSource<ModelType: NSManagedObject>: NSObject, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

    typealias CellProvider = (IndexPath) -> UICollectionViewCell?

    private enum Update<Object> {
        case insert(IndexPath)
        case update(IndexPath)
        case move(IndexPath, IndexPath)
        case delete(IndexPath)
    }

    // MARK: Properties

    private let collectionView: UICollectionView

    private let fetchedResultsController: NSFetchedResultsController<ModelType>

    private var updates: [Update<ModelType>] = []

    private let cellProvider: CellProvider

    // MARK: Initialize

    /// Initializes a new instance of `CollectionViewFetchedResultsDataSource`.
    ///
    /// - Paramater collectionView: The UICollectionView instance for which to be the datasource.
    /// - Paramater fetchedResultsController: The `NSFetchedResultsController` that drives the collectionview.
    init(collectionView: UICollectionView, fetchedResultsController: NSFetchedResultsController<ModelType>, cellProvider: @escaping CellProvider) {
        self.collectionView = collectionView
        self.fetchedResultsController = fetchedResultsController
        self.cellProvider = cellProvider
        super.init()

        fetchedResultsController.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        performFetch()
    }

    // MARK: Access

    /// Returns the object of type `ModelType` at the given IndexPath
    ///
    /// - Paramater indexPath: The indexPath that specifies the location of the requested object.
    func objectAtIndexPath(_ indexPath: IndexPath) -> ModelType {
        return fetchedResultsController.object(at: indexPath)
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: - IF empty show a placeholder view
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = cellProvider(indexPath) else {
            fatalError("Can't setup cell for item at \(indexPath)")
        }

        return cell
    }

    // MARK: FetchedResultsControllerDelegate

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updates = []
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let indexPath = newIndexPath else { fatalError("Index path should be not nil") }
            updates.append(.insert(indexPath))

        case .update:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            updates.append(.update(indexPath))

        case .move:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            guard let newIndexPath = newIndexPath else { fatalError("New index path should be not nil") }
            updates.append(.move(indexPath, newIndexPath))

        case .delete:
            guard let indexPath = indexPath else { fatalError("Index path should be not nil") }
            updates.append(.delete(indexPath))
        @unknown default:
            fatalError("Encountered unknown NSFetchedResultsChangeType.")
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        process(updates: updates)
    }

    // MARK: Utils

    private func process(updates: [Update<ModelType>]) {
        guard !updates.isEmpty else { return }

        collectionView.performBatchUpdates({
            for update in updates {
                switch update {
                case .insert(let indexPath):
                    self.collectionView.insertItems(at: [indexPath])

                case .update(let indexPath):
                    self.collectionView.cellForItem(at: indexPath)

                case .move(let indexPath, let newIndexPath):
                    self.collectionView.deleteItems(at: [indexPath])
                    self.collectionView.insertItems(at: [newIndexPath])

                case .delete(let indexPath):
                    self.collectionView.deleteItems(at: [indexPath])
                }
            }
        }, completion: nil)
    }

    private func performFetch() {
        // swiftlint:disable:next force_try
        try! fetchedResultsController.performFetch()
    }
}
